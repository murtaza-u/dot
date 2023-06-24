{ ... }:

{
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
      ];
    };
    themes.mytheme = {
      inherits = "onelight";
      "ui.background" = { };
    };
  };
}
