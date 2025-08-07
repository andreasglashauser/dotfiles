# ~/.bashrc.d/tmux.sh  (or wherever you start tmux)
if command -v tmux >/dev/null \
   && [ -n "$PS1" ] \
   && [ -z "$TMUX" ] \
   && [[ ! "$TERM" =~ (screen|tmux) ]] \
   && [ -t 0 ] \
   && [[ "$TERM_PROGRAM" != vscode ]] \
   && [[ "$TERM_PROGRAM" != cursor ]]; then

    # Find an unattached session
    unattached_session=$(tmux list-sessions -F '#{session_name}:#{?session_attached,0,1}' 2>/dev/null | awk -F: '$2 == 1 {print $1; exit}')

    if [ -n "$unattached_session" ]; then
      # Attach to the unattached session
      tmux attach-session -t "$unattached_session"
    else
      # Create a new session if no unattached sessions are found
      tmux new-session
    fi
fi


