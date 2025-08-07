package commands

import (
	"fmt"
	"github.com/urfave/cli/v2"
//	"os"
)

func Update(c *cli.Context) error {
	fmt.Println("Updating package list...")
	// TODO: Pull package index from remote
	return nil
}
