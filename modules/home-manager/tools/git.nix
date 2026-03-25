{ config, lib, ... }:

{
  options = {
    tools.git.enable = lib.mkEnableOption "Enable git and gh-cli";
  };

  config = lib.mkIf config.tools.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Murtaza Udaipurwala";
          email = "murtaza@murtazau.xyz";
        };
        init = {
          defaultBranch = "main";
        };
      };
      signing = {
        key = "murtaza@murtazau.xyz";
        signByDefault = true;
      };
      hooks = {
        pre-commit = ../../../dotfiles/git-hooks/pre-commit;
      };
    };
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
