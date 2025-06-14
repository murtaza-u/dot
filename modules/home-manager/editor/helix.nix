{ config, lib, unstable, ... }:

{
  options = {
    editor.helix.enable = lib.mkEnableOption "Enable helix";
  };

  config = lib.mkIf config.editor.helix.enable {
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
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          C-p = [ "file_picker" ];
        };
      };
      languages = {
        formatter = {
          command = "sed";
          args = [ "s/[ \t]*$//" ];
        };
        auto-format = true;
        language = [
          {
            name = "nix";
            formatter = { command = "nixpkgs-fmt"; };
          }
        ];
      };
      themes.modus_operandi_transparent = {
        inherits = "modus_operandi";
        "ui.background" = { fg = "foreground"; };
        "ui.gutter" = { };
      };
    };
  };
}
