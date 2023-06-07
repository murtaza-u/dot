{ config, pkgs, zpkgs, ... }:

{
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    helix = {
      enable = true;
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
    gpg.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  home.file = {
    ".profile".source = ../store/profile;
    ".bashrc".source = ../store/bashrc;
    ".tmux.conf".source = ../store/tmux.conf;
    ".w3m".source = ../store/w3m;
    ".vimrc".source = ../store/vimrc;
  };

  xdg.configFile = {
    nvim = {
      source = ../store/nvim;
      recursive = true;
    };
    emacs.source = ../store/emacs;
    vifm.source = ../store/vifm;
    dircolors.source = ../store/dircolors;
  };

  xdg.dataFile = {
    snippets = {
      source = ../store/snippets;
      recursive = true;
    };
  };

  home.username = "murtaza";
  home.homeDirectory = "/home/murtaza";
  home.packages = [
    pkgs.file
    pkgs.zip
    pkgs.unzip
    pkgs.tree
    pkgs.tmux
    pkgs.w3m
    pkgs.vifm
    pkgs.gh
    pkgs.neovim
    pkgs.ripgrep
    pkgs.jq
    zpkgs.default
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
