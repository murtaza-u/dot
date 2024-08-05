{ pkgs, stateVersion, username, ... }@inputs:
let
  homeDirectory = "/home/${username}";
in
{
  imports = [ ../../modules ];

  # let home manager install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.file = {
    ".bashrc".source = ../../store/bashrc;
    ".bash_profile".source = ../../store/bash_profile;
  };
  home.packages = [
    pkgs.xclip
    pkgs.file
    pkgs.tree
    pkgs.bc
    pkgs.ffmpeg
    pkgs.imagemagick
    pkgs.jq
    pkgs.ripgrep
    pkgs.neovim
    pkgs.keepassxc
    pkgs.vscodium
    pkgs.qbittorrent
    pkgs.element-desktop
    pkgs.calibre
  ] ++ [
    (import ../../scripts/youtube.nix { inherit pkgs; })
    (import ../../scripts/docx2pdf.nix { inherit pkgs; })
    (import ../../scripts/qrfromimg.nix { inherit pkgs; })
    (import ../../scripts/fish.nix { inherit pkgs; })
    (import ../../scripts/figl.nix { inherit pkgs; })
    (import ../../scripts/whichkey.nix { inherit pkgs; })
    (import ../../scripts/extract.nix { inherit pkgs; })
    (import ../../scripts/media-duration.nix { inherit pkgs; })
  ];

  xdg.enable = true;
  xdg.configFile.dircolors.source = ../../store/dircolors;

  desktop = {
    theme = {
      gtk.enable = true;
      qt.enable = true;
      xresources.enable = true;
    };
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
    w3m.enable = true;
    newsboat.enable = true;
  };
  editor.vim.enable = true;
  system.syncthing.enable = true;
}
