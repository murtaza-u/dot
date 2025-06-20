{ pkgs, config, lib, ... }:

{
  options = {
    editor.vim = {
      enable = lib.mkEnableOption "Enable vim";
      defaultEditor = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set vim as the default editor";
      };
    };
  };

  config = lib.mkIf config.editor.vim.enable {
    home.sessionVariables = lib.mkIf config.editor.vim.defaultEditor {
      EDITOR = "vim";
    };
    home.packages = [ pkgs.vim ];
    home.file.".vimrc".source = ../../../dotfiles/vimrc;
  };
}
