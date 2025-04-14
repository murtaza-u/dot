{ lib, nixpkgs, pkgs, ... }:

{
  imports = [ ./virtualisation.nix ];

  nix = {
    # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by
    # this flake.
    registry.nixpkgs.flake = nixpkgs;
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      # https://github.com/NixOS/nix/issues/9574
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # but NIX_PATH is still used by many useful tools, so we set it to the same
  # value as the one used by this flake.
  #
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this
  # flake.
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-u28n";
    useXkbConfig = true; # use xkb.options in tty.
  };

  environment.systemPackages = with pkgs; [ nvi ];
}
