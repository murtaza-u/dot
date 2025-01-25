{ config, lib, ... }:

{
  options = {
    desktop.chromium.enable = lib.mkEnableOption "Enable chromium";
  };

  config = lib.mkIf config.desktop.chromium.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
        { id = "bhchdcejhohfmigjafbampogmaanbfkg"; } # user-agent spoofer
        { id = "oboonakemofpalcgghocfoadofidjkkk"; } # keepassxc-browser
      ];
    };
  };
}
