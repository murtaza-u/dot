{ pkgs, config, lib, ... }:

{
  options = {
    editor.vim.enable = lib.mkEnableOption "Enable vim";
  };

  config = lib.mkIf config.editor.vim.enable {
    home.packages = [ pkgs.nvi ];
    home.file.".vimrc".source = ../../../dotfiles/vimrc;
  };
}
