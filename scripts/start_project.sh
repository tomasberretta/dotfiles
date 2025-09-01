#!/bin/bash
# A standalone script to create or switch to a tmux session for development.
# This version correctly handles being run from inside an existing tmux session
# and has improved session name sanitization.

# Get the current directory name.
DIR_NAME=$(basename "$PWD")

# Sanitize the name for tmux: replace periods and colons with underscores.
SANITIZED_SESSION_NAME=$(echo "$DIR_NAME" | sed 's/[:.]/_/g')

SESSION_NAME="dev-$SANITIZED_SESSION_NAME"
# Check if a tmux session with this EXACT name already exists.
# The '= ' is important for an exact match.
if ! tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
	echo "Creating new session: $SESSION_NAME"

	# Create a new detached session. The -c flag sets the starting directory.
	tmux new-session -d -s "$SESSION_NAME" -n "ide" -c "$PWD"

	# --- Window 1: ide ---
	tmux split-window -v -p 15 -t "$SESSION_NAME:ide" -c "$PWD"
	tmux select-pane -t "$SESSION_NAME:ide.1"
	tmux split-window -h -p 25 -t "$SESSION_NAME:ide" -c "$PWD"
	tmux send-keys -t "$SESSION_NAME:ide.1" "nvim ." C-m
	tmux select-pane -t "$SESSION_NAME:ide.1"

	# --- Window 2: terminal ---
	tmux new-window -t "$SESSION_NAME" -n "terminal" -c "$PWD"

	# Select the "ide" window to be the active one.
	tmux select-window -t "$SESSION_NAME:ide"
fi

# Now, connect to the session (which is guaranteed to exist).
if [ -z "$TMUX" ]; then
	# We are OUTSIDE tmux, so attach a new client.
	echo "Attaching to session: $SESSION_NAME"
	tmux attach-session -t "$SESSION_NAME"
else
	# We are INSIDE tmux, so switch the current client.
	echo "Switching to session: $SESSION_NAME"
	tmux switch-client -t "$SESSION_NAME"
fi
