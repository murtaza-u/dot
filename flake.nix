{
  description = "Murtaza Udaipurwala's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    z = {
      url = "github:murtaza-u/z/v0.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, unstable-nixpkgs, home-manager, z, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = nixpkgs.lib;
      stateVersion = "24.05";
      username = "murtaza";
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [ nixpkgs-fmt nixd ];
      };
      nixosConfigurations.workstation = lib.nixosSystem {
        inherit system;
        modules = [
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            system.stateVersion = stateVersion;
          }
          ./hosts/workstation
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "bkp";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./hosts/workstation/home.nix;
            home-manager.extraSpecialArgs = {
              inherit pkgs;
              inherit stateVersion;
              inherit username;
              unstable-nixpkgs = import unstable-nixpkgs { inherit system; };
              zpkgs = z.packages.${system};
            };
          }
        ];
      };
    };
}
