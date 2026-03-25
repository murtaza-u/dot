{ inputs, lib, ... }:

{
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this
  # flake.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry.unstable.flake = inputs.unstable-nixpkgs;

  # remove nix-channel related tools & configs, we use flakes instead.
  nix.channel.enable = false;

  # but NIX_PATH is still used by many useful tools, so we set it to the same
  # value as the one used by this flake.
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this
  # flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  # https://github.com/NixOS/nix/issues/9574
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

  nix.settings.flake-registry = "${inputs.flake-registry}/flake-registry.json";
}
