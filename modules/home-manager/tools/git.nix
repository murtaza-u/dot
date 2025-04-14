{ config, lib, ... }:

{
  options = {
    tools.git.enable = lib.mkEnableOption "Enable git and gh-cli";
  };

  config = lib.mkIf config.tools.git.enable {
    programs.git = {
      enable = true;
      userName = "Murtaza Udaipurwala";
      userEmail = "murtaza@murtazau.xyz";
      signing = {
        key = "murtaza@murtazau.xyz";
        signByDefault = true;
      };
      hooks = {
        pre-commit = ../../../dotfiles/git-hooks/pre-commit;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
