{ pkgs, ... }:

{
  # xdg.configFile.nvim = {
  #   source = ../../store/nvim;
  #   recursive = true;
  # };
  home.file.".vimrc".source = ../../store/vimrc;
  home.packages = [ pkgs.neovim ];
}
