{ pkgs, config, lib, ... }:

{
  options = {
    tools.tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tools.tmux.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 10000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      mouse = true;
      prefix = "C-s";
      sensibleOnTop = false;
      terminal = "tmux-256color";
      extraConfig = ''
        # window splitting
        bind-key | split-window -h
        bind-key _ split-window -v
        unbind '"'
        unbind %

        # easy kill
        bind-key X kill-window

        # add double-tap prefix key to toggle last window
        bind-key C-s last-window

        # automatically renumber windows
        set -g renumber-windows on

        # avoid cursor movement messing with resize
        set -g repeat-time 200

        # form vim/tmux d/y buffer sync
        set-option -g focus-events on

        # better copy
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel '${pkgs.xclip}/bin/xclip -in -sel c'

        # status bar
        set -g status-position top
        set -g status-interval 1
        set -g status-right "#(z pomo)"
        set -g status-left-length 60
        set -g status-style bg=default

        # looks good with any terminal theme
        set -g pane-border-style fg=default,bg=default
        set -g pane-active-border-style fg=default,bg=default

        # fixes/hacks
        set -ag terminal-overrides ",xterm-256color:RGB"

        # undercurl support
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'

        # underscore colours
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      '';
    };
  };
}
