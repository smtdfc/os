package helpers

import (
	"archive/tar"
	"bytes"
	"compress/gzip"
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"path/filepath"
)

type PkgMetadata struct {
	Name   string `json:"name"`
	Ver    string `json:"ver"`
	Author string `json:"author"`
}

func FindPkg(name string) (PkgMetadata, error) {
	payload := map[string]string{"name": name}
	jsonData, err := json.Marshal(payload)
	if err != nil {
		return PkgMetadata{}, err
	}

	url := os.Getenv("TIGER_REGISTRY_HOST") + "/api/pkg/info"
	resp, err := http.Post(url, "application/json", bytes.NewBuffer(jsonData))
	if err != nil {
		return PkgMetadata{}, err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return PkgMetadata{}, err
	}

	if resp.StatusCode != http.StatusOK {
		var errResp map[string]string
		if err := json.Unmarshal(body, &errResp); err == nil {
			if msg, ok := errResp["error"]; ok {
				return PkgMetadata{}, fmt.Errorf("server error: %s", msg)
			}
		}
		return PkgMetadata{}, fmt.Errorf("find failed: status %d, response: %s", resp.StatusCode, string(body))
	}

	var metadata PkgMetadata
	if err := json.Unmarshal(body, &metadata); err != nil {
		return PkgMetadata{}, err
	}

	return metadata, nil
}

func DownloadPkg(pkg PkgMetadata) error {
	baseURL := os.Getenv("TIGER_REGISTRY_HOST")
	downloadURL := fmt.Sprintf("%s/api/pkg/download/%s", baseURL, pkg.Name)

	resp, err := http.Get(downloadURL)
	if err != nil {
		return fmt.Errorf("download failed: %v", err)
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("failed to read response body: %v", err)
	}

	if resp.StatusCode != http.StatusOK {
		var errResp map[string]string
		if err := json.Unmarshal(body, &errResp); err == nil {
			if msg, ok := errResp["error"]; ok {
				return fmt.Errorf("server error: %s", msg)
			}
		}
		return fmt.Errorf("download failed: status %d, response: %s", resp.StatusCode, string(body))
	}

	outputDir := filepath.Join("pkg", pkg.Name)
	if err := os.MkdirAll(outputDir, 0755); err != nil {
		return fmt.Errorf("failed to create output dir: %v", err)
	}

	if err := extractTarGz(body, outputDir); err != nil {
		return fmt.Errorf("failed to extract archive: %v", err)
	}
	fmt.Printf("📦 Package %s extracted to %s/\n", pkg.Name, outputDir)

	metadataPath := filepath.Join(outputDir, "metadata.json")
	metaDataJSON, err := json.MarshalIndent(pkg, "", "  ")
	if err != nil {
		return fmt.Errorf("failed to encode metadata: %v", err)
	}

	if err := os.WriteFile(metadataPath, metaDataJSON, 0644); err != nil {
		return fmt.Errorf("failed to write metadata.json: %v", err)
	}

	fmt.Printf("📄 metadata.json written to %s\n", metadataPath)

	symlinkDir := "bin"
	if err := os.MkdirAll(symlinkDir, 0755); err != nil {
		return fmt.Errorf("failed to create bin directory: %v", err)
	}

	targetBinary := filepath.Join(outputDir, pkg.Name)
	symlinkPath := filepath.Join(symlinkDir, pkg.Name)

	_ = os.Remove(symlinkPath)

	if err := os.Symlink(targetBinary, symlinkPath); err != nil {
		return fmt.Errorf("failed to create symlink: %v", err)
	}

	fmt.Printf("🔗 Symlink created: %s → %s\n", symlinkPath, targetBinary)
	return nil
}

func extractTarGz(data []byte, dest string) error {
	gzr, err := gzip.NewReader(bytes.NewReader(data))
	if err != nil {
		return fmt.Errorf("gzip error: %v", err)
	}
	defer gzr.Close()

	tarReader := tar.NewReader(gzr)

	for {
		header, err := tarReader.Next()
		if err == io.EOF {
			break
		}
		if err != nil {
			return err
		}

		target := filepath.Join(dest, header.Name)

		switch header.Typeflag {
		case tar.TypeDir:
			if err := os.MkdirAll(target, os.FileMode(header.Mode)); err != nil {
				return err
			}
		case tar.TypeReg:
			outFile, err := os.Create(target)
			if err != nil {
				return err
			}
			if _, err := io.Copy(outFile, tarReader); err != nil {
				outFile.Close()
				return err
			}
			outFile.Close()
		default:
			fmt.Printf("⚠️ Skipping unknown file type in archive: %s\n", header.Name)
		}
	}
	return nil
}
