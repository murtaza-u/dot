{ config, pkgs, unstable-pkgs, ... }:

{
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    helix = {
      enable = true;
      package = unstable-pkgs.helix;
      settings = {
        theme = "onelight";
        editor = {
          true-color = true;
          idle-timeout = 0;
          gutters = [ "diagnostics" ];
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          "{" = [ "goto_prev_paragraph" ];
          "}" = [ "goto_next_paragraph" ];
          C-p = [ "file_picker" ];
        };
      };
      languages = {
        language = [
          {
            name = "javascript";
            auto-format = true;
          }
          {
            name = "markdown";
            language-server = { command = "ltex-ls"; };
            file-types = [ "md" "txt" ];
            scope = "source.markdown";
            roots = [ ];
          }
        ];
      };
    };
    zathura = {
      enable = false;
      mappings = {
        R = "rotate";
        i = "recolor";
      };
      options = {
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 1;
        selection-clipboard = "clipboard";
        recolor-lightcolor = "#161515";
        recolor-keephue = true;
        default-bg = "#ffffff";
      };
    };
    git = {
      enable = true;
      userName = "Murtaza Udaipurwala";
      userEmail = "murtaza@murtazau.xyz";
      signing = {
        key = "murtaza@murtazau.xyz";
        signByDefault = true;
      };
      hooks = {
        pre-commit = ../store/git-hooks/pre-commit;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    newsboat = {
      enable = true;
      autoReload = false;
      urls = [
        {
          url = "https://xeiaso.net/blog.rss";
          tags = [ "technology" ];
        }
      ];
      extraConfig = ''
        bind-key j down
        bind-key k up
        bind-key j next articlelist
        bind-key k prev articlelist
        bind-key J next-feed articlelist
        bind-key K prev-feed articlelist
        bind-key G end
        bind-key g home
        bind-key d pagedown
        bind-key u pageup
        bind-key l open
        bind-key h quit
        bind-key a toggle-article-read
        bind-key n next-unread
        bind-key N prev-unread
        bind-key D pb-download
        bind-key U show-urls
        bind-key x pb-delete

        color listnormal        default default
        color listnormal_unread default default
        color listfocus         default default reverse bold
        color listfocus_unread  default default reverse bold
        color info              default default reverse
        color background        default default
        color article           default default
      '';
    };
    rofi = {
      enable = false;
      theme = ../store/rofi/theme.rasi;
      cycle = true;
      font = "Iosevka Medium 14";
      plugins = with pkgs; [ rofi-emoji ];
      extraConfig = {
        show-icons = true;
        icon-theme = "breeze_icons";
        modi = "window,run,drun,emoji";
        drun-display-format = "{icon} {name}";
        display-window = "Windows: ";
        display-drun = "Applications: ";
        display-run = "Run: ";
        display-emoji = "Emoji: ";
      };
    };
    chromium = {
      enable = false;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
        { id = "bhchdcejhohfmigjafbampogmaanbfkg"; } # user-agent spoofer
      ];
    };
    gpg.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  gtk = {
    enable = false;
    theme = {
      name = "Breeze";
      package = pkgs.breeze-gtk;
    };
    font = {
      name = "Roboto Medium";
      size = 11;
      package = pkgs.roboto;
    };
    iconTheme = {
      name = "breeze";
      package = pkgs.breeze-icons;
    };
    cursorTheme = {
      name = "breeze_cursors";
    };
  };

  qt = {
    enable = false;
    platformTheme = "gtk";
    style = {
      name = "Breeze";
      package = "breeze-qt";
    };
  };

  xsession.enable = false;

  services.picom = {
    enable = false;
    activeOpacity = 1.0;
    fade = true;
    fadeDelta = 5;
    fadeExclude = [ "class_g = 'Rofi'" ];
    fadeSteps = [ 0.03 0.03 ];
    shadow = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  services.dunst = {
    enable = false;
    iconTheme = {
      name = "Breeze";
      package = pkgs.breeze-icons;
    };
    settings = rec {
      global = {
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "4x4";
        transparency = 10;
        separator_height = 2;
        padding = 10;
        gap_size = 10;
        horizontal_padding = 10;
        text_icon_padding = 3;
        frame_width = 2;
        frame_color = "#eeeeee";
        font = "Roboto Medium 14";
        icon_position = "left";
        corner_radius = 6;
        force_xwayland = false;
      };
      urgency_normal = {
        background = "#eeeeee";
        foreground = "#000000";
        timeout = 5;
      };
      urgency_low = urgency_normal;
      urgency_critical = {
        background = "#eeeeee";
        foreground = "#000000";
        frame_color = "#ff0000";
        timeout = 5;
      };
    };
  };

  home.file = {
    ".profile".source = ../store/profile;
    ".bashrc".source = ../store/bashrc;
    ".tmux.conf".source = ../store/tmux.conf;
    ".w3m".source = ../store/w3m;
    ".vimrc".source = ../store/vimrc;
    ".xinitrc".source = ../store/xinitrc;
    ".Xresources".source = ../store/Xresources;
  };

  xdg.configFile = {
    nvim = {
      source = ../store/nvim;
      recursive = true;
    };
    emacs.source = ../store/emacs;
    vifm.source = ../store/vifm;
    dircolors.source = ../store/dircolors;
    alacritty.source = ../store/alacritty;
    sxhkd.source = ../store/sxhkd;
    bspwm.source = ../store/bspwm;
  };

  xdg.dataFile = {
    snippets = {
      source = ../store/snippets;
      recursive = true;
    };
  };

  home.username = "murtaza";
  home.homeDirectory = "/home/murtaza";
  home.packages = with pkgs; [
    file
    unzip
    tree
    tmux
    w3m
    vifm
    gh
    neovim
    jq
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
