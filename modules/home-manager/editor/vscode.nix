{ pkgs, config, lib, ... }:

{
  options = {
    editor.vscode.enable = lib.mkEnableOption "Enable vscode";
  };

  config = lib.mkIf config.editor.vscode.enable {
    programs.vscode = {
      package = pkgs.vscodium;
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        enkia.tokyo-night
        yoavbls.pretty-ts-errors
      ];
      userSettings = {
        # disable clutter
        "editor.minimap.enabled" = false;
        "breadcrumbs.enabled" = false;
        "workbench.activityBar.location" = "hidden";
        "workbench.startupEditor" = "none";
        "workbench.editor.editorActionsLocation" = "hidden";
        "window.menuBarVisibility" = "toggle";
        "files.exclude" = {
          "**/.direnv" = true;
          "**/.react-router" = true;
        };

        "editor.stickyScroll.enabled" = false;
        "editor.fontFamily" = "'ZedMono Nerd Font'";
        "editor.tabSize" = 2;
        "editor.fontSize" = 16;
        "terminal.integrated.fontSize" = 16;

        # set theme
        "workbench.colorTheme" = "Tokyo Night Light";

        # I have Caps Lock mapped to Escape. Without this setting, the remap
        # doesn't work inside vscode.
        "keyboard.dispatch" = "keyCode";

        "git.openRepositoryInParentFolders" = "never";
      };
      keybindings = [
        {
          key = "ctrl+p";
          command = "-extension.vim_ctrl+p";
          when = "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
        }
      ];
    };
  };
}
