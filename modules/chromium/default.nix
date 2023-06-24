{ ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "bhchdcejhohfmigjafbampogmaanbfkg"; } # user-agent spoofer
    ];
  };
}
