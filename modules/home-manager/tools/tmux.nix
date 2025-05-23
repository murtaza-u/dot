{ pkgs, config, lib, ... }:

{
  options = {
    tools.tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tools.tmux.enable {
    home.file.".tmux.conf".source = ../../../dotfiles/tmux.conf;
    home.packages = [ pkgs.tmux ];
  };
}
