#!/usr/local/bin/bash

#***********************#
#******* Options *******#
#***********************#

# Defaults
APPLICATION="winslow"
TARGET="macduff"

while getopts “:a:t:” opt; do
  case "${opt}" in
    a) APPLICATION=$OPTARG ;;
    t) TARGET=$OPTARG ;;
  esac
done

case "${APPLICATION}" in
  winslow) PORT=6543 ;;
  citadel) PORT=5543 ;;
  *) PORT=6543 ;;
esac

# TODO: Create command line option for virtual env
vex_env="3.8.2"
deus_lex_home="~/Programming/deus_lex"

echo "Application: $APPLICATION:$PORT"
echo "Target: $TARGET"


#**********************#
#******* Macros *******#
#**********************#

# Open a new vertical split pane in iTerm2
function term_vertical_split() {
  osascript \
  -e 'tell application "iTerm" to activate' \
  -e 'tell application "System Events" to tell process "iTerm" to key code 2 using command down'
}

# Open an new iTerm2 tab
function term_new_tab() {
  osascript \
  -e 'tell application "iTerm" to activate' \
  -e 'tell application "System Events" to tell process "iTerm" to keystroke "t" using command down'
}

# Enter virtual environment and change to deus_lex root directory
function change_dir_and_vex() {
  osascript \
  -e 'tell application "System Events" to tell process "iTerm" to keystroke "vex '$vex_env'"' \
  -e 'tell application "System Events" to tell process "iTerm" to key code 52' \
  -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd '$deus_lex_home'"' \
  -e 'tell application "System Events" to tell process "iTerm" to key code 52'
}


#***********************#
#******* Scripts *******#
#***********************#

# Create Tunnel to target environment
osascript -e 'tell application "iTerm" to activate'

change_dir_and_vex

osascript \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "gmake 'tunnel-$TARGET'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52'


# Run pserve in new vertical split pane
term_vertical_split
change_dir_and_vex

osascript \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "pserve --reload ./'$APPLICATION'/dev-tunnel-all-'$TARGET'.ini"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52'


# Run the application watch server in new vertical split pane
term_vertical_split
change_dir_and_vex

osascript \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "gmake '$APPLICATION-frontend-watch'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52'


# Run `git branch` in a new tab
term_new_tab
change_dir_and_vex

osascript \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "git branch"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52'


# Open application in new Chrome tab
open -a "Google Chrome" http://localhost:$PORT
