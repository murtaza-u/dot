{
  description = "Dotfile management with flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    z = {
      url = "github:murtaza-u/z";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      zpkgs = inputs.z.packages.${system};
      stateVersion = "23.11";
      username = "murtaza";
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
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
            home-manager.extraSpecialArgs = {
              inherit zpkgs;
              inherit stateVersion;
              inherit username;
            };
          }
        ];
      };
    };
}
