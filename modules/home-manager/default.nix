{ pkgs, stateVersion, username, ... }:

{
  home.stateVersion = stateVersion;
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.file = {
    ".profile".source = ../../store/profile;
    ".bashrc".source = ../../store/bashrc;
    ".tmux.conf".source = ../../store/tmux.conf;
    ".w3m".source = ../../store/w3m;
  };
  home.packages = with pkgs; [
    file
    zip
    unzip
    tree
    bc
    perl
    ffmpeg
    imagemagick
    jq
    tmux
    w3m
    gh
    ripgrep
    iosevka
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.configFile.dircolors.source = ../../store/dircolors;
  xdg.dataFile.snippets = {
    source = ../../store/snippets;
    recursive = true;
  };
}
