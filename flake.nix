{
  description = "Dotfile management with flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      nixosConfigurations.shiganshina = lib.nixosSystem {
        inherit system;
        modules = [
          { nix.registry.nixpkgs.flake = nixpkgs; }
          ./shiganshina/configuration.nix
        ];
      };
      nixosConfigurations.workstation = lib.nixosSystem {
        inherit system;
        modules = [
          { nix.registry.nixpkgs.flake = nixpkgs; }
          ./workstation/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.murtaza = import ./workstation/home.nix;
            home-manager.extraSpecialArgs = { inherit zpkgs; };
          }
        ];
      };
      # standalone home-manager for WSL2
      homeManagerConfigurations = {
        murtaza = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            { nix.registry.nixpkgs.flake = nixpkgs; }
            ./wsl/home.nix
          ];
          extraSpecialArgs = { inherit zpkgs; };
        };
      };
    };
}
