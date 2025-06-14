{ pkgs, ... }:

{
  imports = [
    ./virtualisation.nix
    ./channels.nix
  ];

  nix = {
    settings = {
      trusted-users = [ "murtaza" ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-u28n";
    useXkbConfig = true; # use xkb.options in tty.
  };

  environment.systemPackages = with pkgs; [ vim ];
}
