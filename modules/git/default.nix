{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Murtaza Udaipurwala";
    userEmail = "murtaza@murtazau.xyz";
    signing = {
      key = "murtaza@murtazau.xyz";
      signByDefault = true;
    };
    hooks = {
      pre-commit = ../../store/git-hooks/pre-commit;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
