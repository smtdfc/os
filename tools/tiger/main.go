package main

import (
	"fmt"
	"github.com/urfave/cli/v2"
	"os"
	"tiger/commands"
)

func main() {
	app := &cli.App{
		Name:  "tiger",
		Usage: "Package manager for smtdfc OS",
		Commands: []*cli.Command{
			{
				Name:   "install",
				Usage:  "Install a package",
				Action: commands.Install,
			},
			{
				Name:   "remove",
				Usage:  "Remove a package",
				Action: commands.Remove,
			},
			{
				Name:   "search",
				Usage:  "Search for a package",
				Action: commands.Search,
			},
			{
				Name:   "update",
				Usage:  "Update package list",
				Action: commands.Update,
			},
		},
	}

	if err := app.Run(os.Args); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
