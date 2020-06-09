#!/usr/local/bin/bash

vex_env="3.8.2"
deus_lex_home="~/Programming/deus_lex"

# Run `git branch` in a new tab
osascript \
-e 'tell application "iTerm" to activate' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "t" using command down' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "vex '$vex_env'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "cd '$deus_lex_home'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
