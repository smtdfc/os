package commands

import (
	"fmt"
	"github.com/urfave/cli/v2"
	"os"
	"tiger/helpers"
)

func Install(c *cli.Context) error {
	pkg := c.Args().First()
	if pkg == "" {
		fmt.Fprintln(os.Stderr, "Error: Package name required")
		return cli.Exit("", 1)
	}

	fmt.Printf("Revolving package: %s\n", pkg)
	metadata, err := helpers.FindPkg(pkg)

	if err != nil {
		fmt.Fprintln(os.Stderr, "Error: Cannot resolve package "+pkg)
		fmt.Println(err)
		return nil
	}

	fmt.Printf("Downloading package: %s\n", pkg)

	err = helpers.DownloadPkg(metadata)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error: Cannot install package "+pkg)
		fmt.Println(err)
		return nil
	}

	return nil
}
