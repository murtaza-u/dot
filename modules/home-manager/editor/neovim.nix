{ config, lib, unstable, ... }:

{
  options = {
    editor.neovim = {
      enable = lib.mkEnableOption "Enable neovim";
      defaultEditor = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set neovim as the default editor";
      };
    };
  };

  config = lib.mkIf config.editor.neovim.enable {
    home.sessionVariables = lib.mkIf config.editor.neovim.defaultEditor {
      EDITOR = "nvim";
    };
    home.packages = [ unstable.neovim ];
  };
}
