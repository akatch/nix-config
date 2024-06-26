{
  programs.tmux = {
    enable = true;
    extraConfig =
      ''
        unbind '"'
        unbind '%'
        unbind ,
        unbind Space
        unbind t

        set -g prefix '`'
        bind '`' send-prefix

        setw -g history-limit 10000
        setw -g aggressive-resize on
        set -g base-index 1
        set -g pane-base-index 1
        set -g display-time 3000
        set -g renumber-windows on
        set -g bell-action none
        set -g visual-bell off
        set -g repeat-time 200
        set -g mouse on
        set -g default-terminal "tmux-256color"

        set -g mode-style fg=colour214
        set -g pane-border-style fg=colour234
        set -g pane-active-border-style fg=colour64
        set -g message-style fg=colour172
        set -g clock-mode-colour colour29

        bind r source-file ~/.tmux.conf
        bind a attach -d
        bind ] paste-buffer -s ' '
        bind '}' paste-buffer -r
        bind s split-window -c "#{pane_current_path}"
        bind Enter split-window -l 25% -c "#{pane_current_path}"
        bind v split-window -h -c "#{pane_current_path}"
        bind -r h select-pane -L
        bind -r j select-pane -D
        bind -r k select-pane -U
        bind -r l select-pane -R
        bind e command-prompt -p "vim -p" "split-window vim -p %%"
        bind m command-prompt -p "man" "split-window man %%"
        bind , command-prompt -p "session" "switch-client -t %%"
        bind t command-prompt -p "todo.txt" "run-shell -b 'todo %%'"
        bind X confirm-before -p "kill window #I?" "kill-window"
        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-selection
        bind -T copy-mode-vi x send-keys -X copy-pipe 'xclip -selection clipboard -i'
        bind -T copy-mode-vi X send-keys -X copy-pipe 'xclip -selection primary -i'
        bind -T copy-mode-vi Escape send-keys -X cancel

        # statusbar
        set -g status on
        #set -g status-interval 1
        set -g status-fg colour64
        set -g status-style bg=default
        set -g window-status-separator ""
        set -g window-status-format ""
        set -g window-status-current-format ""

        # Fancy status line
        set -g status-left-length 50
        set -g status-right-length 150
        set -g status-left "#S@#H #W"
        set -g status-right ""
      '';
  };
}
