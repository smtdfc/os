package commands

import (
	"fmt"
	"github.com/urfave/cli/v2"
	"os"
)

func Search(c *cli.Context) error {
	keyword := c.Args().First()
	if keyword == "" {
		fmt.Fprintln(os.Stderr, "Error: Search keyword required")
		return cli.Exit("", 1)
	}
	fmt.Printf("Searching for packages matching: %s\n", keyword)
	// TODO: Search in local or remote repo
	return nil
}
