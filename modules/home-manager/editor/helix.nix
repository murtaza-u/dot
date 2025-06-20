{ config, lib, unstable, ... }:

{
  options = {
    editor.helix = {
      enable = lib.mkEnableOption "Enable helix";
      defaultEditor = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set helix as the default editor";
      };
    };
  };

  config = lib.mkIf config.editor.helix.enable {
    home.sessionVariables = lib.mkIf config.editor.helix.defaultEditor {
      EDITOR = "hx";
    };
    programs.helix = {
      enable = true;
      package = unstable.helix;
      settings = {
        theme = "modus_operandi_transparent";
        editor = {
          line-number = "relative";
          rulers = [ 80 ];
          gutters = [ "diff" "diagnostics" "spacer" ];
          completion-trigger-len = 1;
          end-of-line-diagnostics = "hint";
          cursor-shape = {
            insert = "bar";
            select = "underline";
          };
          indent-guides = {
            render = true;
            skip-levels = 1;
          };
          file-picker.hidden = false;
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          C-p = [ "file_picker" ];
          Z = { Q = ":quit!"; Z = ":write-quit!"; };
        };
      };
      languages.language = [
        {
          name = "nix";
          formatter = { command = "nixpkgs-fmt"; };
          auto-format = true;
        }
      ];
      themes.modus_operandi_transparent = {
        inherits = "modus_operandi";
        "ui.background" = { };
        "ui.gutter" = { };
      };
    };
  };
}
