# line-launcher
Presents a list of commands pulled from a file, then runs the one you select.

# Usage
## Preparing your pre-built commands
Create a plain-text file named `$HOME/.config/launchlines`

This file should have, one per line, the commands you wish to include in the menu.

## Execute the script directly
Save the line-launcher.sh file to your computer, and make it executable using:

`chmod +x line-launcher.sh`

Then just execute the script directly:

`./line-launcher.sh`

## Sourcing the function into your env
The script can also be sourced into your environment in the standard ways.

Manually (for current shell only):
`. line-launcher.sh`

Automatically, just include the above line in your .bashrc or .bash_profile.

Then you have the `line-launcher` command available to you from any directory, since it's now a function of bash.
