{ config, lib, ... }:

{
  options = {
    editor.helix.enable = lib.mkEnableOption "Enable helix";
  };

  config = lib.mkIf config.editor.helix.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "mytheme";
        editor = {
          true-color = true;
          idle-timeout = 0;
          gutters = [ "diagnostics" ];
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          rulers = [ 80 ];
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          "{" = [ "goto_prev_paragraph" ];
          "}" = [ "goto_next_paragraph" ];
          C-p = [ "file_picker" ];
        };
      };
      languages = {
        language = [
          {
            name = "javascript";
            auto-format = true;
          }
          {
            name = "jsx";
            auto-format = true;
          }
          {
            name = "tsx";
            auto-format = true;
          }
          {
            name = "html";
            language-servers = [
              "vscode-html-language-server"
              "tailwindcss-ls"
            ];
            auto-format = true;
          }
          {
            name = "svelte";
            language-servers = [
              "svelteserver"
              "tailwindcss-ls"
            ];
            auto-format = true;
          }
          {
            name = "templ";
            language-servers = [
              "templ"
              "tailwindcss-ls"
            ];
            auto-format = true;
          }
        ];
      };
      themes.mytheme = {
        inherits = "onelight";
        "ui.background" = { };
      };
    };
  };
}
