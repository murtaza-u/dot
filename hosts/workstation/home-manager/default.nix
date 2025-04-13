{ pkgs, unstable, stateVersion, username, ... }@inputs:

{
  # Let home manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    stateVersion = stateVersion;
    username = username;
    homeDirectory = "/home/${username}";
    file = {
      ".bashrc".source = ../../../static/bashrc;
      ".bash_profile".source = ../../../static/bash_profile;
    };
    packages = [
      # utilities
      pkgs.xclip
      pkgs.file
      pkgs.tree
      pkgs.bc
      pkgs.ffmpeg
      pkgs.imagemagick
      pkgs.jq
      pkgs.yq-go
      pkgs.ripgrep
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.awscli2
      pkgs.dnsutils

      # for everything except frontend development
      unstable.neovim

      # tried them all, stuck with this. I also use the KeePassXC browser
      # extension.
      pkgs.keepassxc

      # linux ISOs.
      pkgs.qbittorrent

      # Misc.
      pkgs.gimp
      # pkgs.zoom-us
      pkgs.libreoffice
      pkgs.tailscale-systray
      # pkgs.obsidian
      pkgs.mongodb-compass
      # pkgs.ppsspp-sdl-wayland

      # https://github.com/murtaza-u/z
      inputs.z.default

      (import ../../../scripts/youtube.nix { inherit pkgs; })
      (import ../../../scripts/docx2pdf.nix { inherit pkgs; })
      (import ../../../scripts/qrfromimg.nix { inherit pkgs; })
      (import ../../../scripts/fish.nix { inherit pkgs; })
      (import ../../../scripts/figl.nix { inherit pkgs; })
      (import ../../../scripts/whichkey.nix { inherit pkgs; })
      (import ../../../scripts/extract.nix { inherit pkgs; })
      (import ../../../scripts/media-duration.nix { inherit pkgs; })
      (import ../../../scripts/stopwatch.nix { inherit pkgs; })
    ];
  };

  xdg = {
    # Enable management of XDG base directories.
    enable = true;
    # Pretty colors.
    configFile.dircolors.source = ../../../static/dircolors;
  };

  desktop = {
    theme.xresources.enable = true;
    chromium.enable = true;
    alacritty.enable = true;
    zathura.enable = true;
    nsxiv.enable = true;
    mpv.enable = true;
  };
  tools = {
    git.enable = true;
    direnv.enable = true;
    gpg.enable = true;
    tmux.enable = true;
    vifm.enable = true;
    newsboat.enable = true;
  };
  editor = {
    vim.enable = true;
    vscode.enable = true;
  };
  system.syncthing.enable = true;
}
