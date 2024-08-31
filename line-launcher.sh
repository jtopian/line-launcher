#!/usr/bin/env bash
# line-launcher - presents a selection of prebuilt commands from
# a file, then runs the selected option.
# Copyright (C) 2024 JT Anderson jtanderson@jtopia.org
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

line-launcher () {
# Stash the value of the IFS variable for later
# restoration.
XIFS=$IFS 

# This is the file with your pre-built commands.
linefile=$HOME/.config/launchlines

# Convert the file to an array we can use in the
# script.
mapfile -t array < $linefile

# Usage and warning.
echo -e "line-launcher runs your choice of line from $linefile\nThere is no error checking, the contents of that file are your responsibility.\n\n\tPlease choose from the following:"

# setting IFS here because otherwise the for loop
# will evaluate each space-separated word as an
# individual component to loop through. Setting
# IFS to 'newline' makes the for loop split whole
# lines instead.
IFS=$'\n'
# The iterator which we will be incrementing.
selector=1
# The loop that builds the display.
for c in ${array[@]}: 
  do
    # An if statement could be added here that
    # wouid skip over lines in the file that
    # are blank or contain the word placeholder
    # so that if an item is removed, it does not
    # have to change the selector options for
    # lines farther down the file. I.e., if you
    # remove the 3rd line, then all later options
    # will move up, ruining muscle memory. By
    # excluding blank lines from being displayed,
    # but still incrementing the counter, later
    # items will keep their numbering.

    # Wrap both of these lines in the above if
    # statement, if you decide to add that.

    # Output the choice to the screen
    echo -e "\t\t$selector\t$c"
    # Increment the selector
    let selector++

# Repeat until entire file has been displayed
done

# Restore the IFS variable after finishing the loop.
IFS=$XIFS 

# Get input from the user to select the line to run.
# "Evaluates true" if the input is a number or letter 'q'.
unset number
until [[ $number == +([0-9]) ]] || [[ $number == "q" ]];
  do
    read -r -p "please enter a number (or 'q' to quit): " number
done

# Finally, read the selected line from the file and execute it.
# Awk probably could have done all of this, if I were an actual wizard.
awk -v sel="$number" 'NR == sel { system($0); exit }' $linefile

# function ends here
}


# If the file is being sourced, do nothing, else run the function.
# This allows you to include the file in your .bashrc,
# or run it directly.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then line-launcher; fi

