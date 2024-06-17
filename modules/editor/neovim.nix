{ config, lib, ... }:

{
  options = {
    editor.neovim.enable = lib.mkEnableOption "Enable neovim";
  };

  config = lib.mkIf config.editor.neovim.enable {
    programs.neovim.enable = true;
    xdg.configFile.neovim = {
      source = ../../store/nvim;
      recursive = true;
    };
  };
}
