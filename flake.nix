{
  description = "Dotfile management with flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      unstable-pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
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
            home-manager.extraSpecialArgs = { inherit unstable-pkgs; };
            home-manager.users.murtaza = import ./workstation/home.nix;
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
          extraSpecialArgs = { inherit unstable-pkgs; };
        };
      };
    };
}
