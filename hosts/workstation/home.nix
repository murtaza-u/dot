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
  home.sessionVariables = rec {
    XDG_CONFIG_HOME = "${homeDirectory}/.config";
    XDG_DATA_HOME = "${homeDirectory}/.local/share";
    XDG_CACHE_HOME = "${homeDirectory}/.cache";
    XDG_RUNTIME_DIR = "${homeDirectory}/.local/share/runtime";
    REPOS = "${homeDirectory}/Repos";
    GITUSER = "murtaza-u";
    # go
    CGO_ENABLED = 0;
    GOPATH = "${XDG_DATA_HOME}/go";
    GOBIN = "${GOPATH}/bin";
    # npm
    prefix = "${XDG_DATA_HOME}/npm";
    cache = "${XDG_DATA_HOME}/npm";
    tmp = "${XDG_RUNTIME_DIR}/npm";
    NPM_CONFIG_PREFIX = "${XDG_DATA_HOME}/npm-global";
    # clean up
    LESSHISTFILE = "-";
    # fixes
    MOZ_USE_XINPUT2 = 1; # Mozilla smooth scrolling/touchpads.
    _JAVA_AWT_WM_NONREPARENTING = 1;
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true";
    # colored GCC warnings and errors
    GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
  };
  home.file = {
    ".bashrc".source = ../../store/bashrc;
    ".bash_profile".source = ../../store/bash_profile;
  };
  home.packages = [
    pkgs.xclip
    pkgs.tree
    pkgs.bc
    pkgs.ffmpeg
    pkgs.imagemagick
    pkgs.jq
    pkgs.ripgrep
    pkgs.neovim
    pkgs.keepassxc
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
  };
  tools = {
    git.enable = true;
    direnv.enable = true;
    gpg.enable = true;
    tmux.enable = true;
  };
}
