{ config, lib, ... }:

{
  options = {
    editor.vim.enable = lib.mkEnableOption "Enable vim";
  };

  config = lib.mkIf config.editor.vim.enable {
    programs.vim.enable = true;
    home.file.".vimrc".source = ../../store/vimrc;
  };
}
