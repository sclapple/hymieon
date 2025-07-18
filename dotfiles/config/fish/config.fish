if status is-interactive
    # Commands to run in interactive sessions can go here
    krabby random --no-gmax --padding-left 3 | fastfetch --file-raw -

end

# uv
fish_add_path "/home/damieon/.local/bin"

# pnpm
set -gx PNPM_HOME "/home/damieon/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Fish Vim like keybindings

# Cursor movement
bind \ch backward-char # Ctrl+h → move left
bind \cl forward-char # Ctrl+l → move right
bind \cb backward-word # Ctrl+b → move back by word
bind \cw forward-word # Ctrl+w → move forward by word
bind \ca beginning-of-line # Ctrl+a → move to start of line
bind \ce end-of-line # Ctrl+e → move to end of line

# Deletion
bind \cd kill-word # Ctrl+d → delete word forward
bind \cx backward-kill-word # Ctrl+x → delete word backward
bind \cu kill-line # Ctrl+u → delete from cursor to end

# Autosuggestion
bind \cf accept-autosuggestion # Ctrl+f → accept suggestion
