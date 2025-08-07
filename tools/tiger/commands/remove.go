package commands

import (
	"fmt"
	"github.com/urfave/cli/v2"
	"os"
)

func Remove(c *cli.Context) error {
	pkg := c.Args().First()
	if pkg == "" {
		fmt.Fprintln(os.Stderr, "Error: Package name required")
		return cli.Exit("", 1)
	}
	fmt.Printf("Removing package: %s\n", pkg)
	// TODO: Delete package files
	return nil
}
