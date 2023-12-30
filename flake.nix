{
  description = "Dotfile management with flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      stateVersion = "23.11";
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      nixosConfigurations.workstation = lib.nixosSystem {
        inherit system;
        modules = [
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            system.stateVersion = stateVersion;
          }
          ./configuration.nix
        ];
      };
    };
}
