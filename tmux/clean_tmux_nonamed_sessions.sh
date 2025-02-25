#!/bin/bash

# List all tmux sessions
tmux list-sessions -F "#{session_name}" | while read -r session; do
  # Check if session name is numeric (default naming convention)
  if [[ $session =~ ^[0-9]+$ ]]; then
    # Kill the session if it's numeric
    tmux kill-session -t "$session"
  fi
done

tmux display-message "Non-named sessions cleaned up completed"
 
