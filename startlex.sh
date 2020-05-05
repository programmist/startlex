#!/usr/local/bin/bash

# TODO: Use function to make more DRY
# TODO: Add command options: macduff vs prod, etc.

if [ "$1" = "prod" ]; then
  target="primary"
else
  target="macduff"
fi

vex_env="deus_lex_37"
deus_lex_home="~/Programming/deus_lex"

echo "tunnel-$target"
# function new_vert_pane() {
#   # TODO: Open new vertical split pane in iTerm
# }

# function return() {
#   # TODO: Press the Return key
# }

# Tunnel into macduff
osascript \
-e 'tell application "iTerm" to activate' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "vex '$vex_env'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "cd '$deus_lex_home'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "gmake 'tunnel-$target'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \


# Open pserve tab
osascript \
-e 'tell application "iTerm" to activate' \
-e 'tell application "System Events" to tell process "iTerm" to key code 2 using command down' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "vex '$vex_env'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "cd '$deus_lex_home'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "pserve --reload ./winslow/dev-tunnel-all-'$target'.ini"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \


# Open split pane: gmake winslow-frontend-watch
osascript \
-e 'tell application "iTerm" to activate' \
-e 'tell application "System Events" to tell process "iTerm" to key code 2 using command down' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "vex '$vex_env'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "cd '$deus_lex_home'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "gmake winslow-frontend-watch"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \


# Open git branch tab
osascript \
-e 'tell application "iTerm" to activate' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "t" using command down' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "vex '$vex_env'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "cd '$deus_lex_home'"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \
-e 'tell application "System Events" to tell process "iTerm" to keystroke "git branch"' \
-e 'tell application "System Events" to tell process "iTerm" to key code 52' \


# Open Winslow in new Chrome tab
open -a "Google Chrome" http://localhost:6543
