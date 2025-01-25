{
  description = "Murtaza Udaipurwala's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    z = {
      url = "github:murtaza-u/z/v0.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, unstable, home-manager, nur, z, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "zoom"
          "corefonts"
          "mongodb-compass"
        ];
        overlays = [ nur.overlays.default ];
      };
      lib = nixpkgs.lib;
      stateVersion = "24.11";
      username = "murtaza";
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [ nixpkgs-fmt nixd ];
      };
      nixosConfigurations.workstation = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [
          home-manager.nixosModules.home-manager
          ./modules/nixos
          ./hosts/workstation/nixos
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            system.stateVersion = stateVersion;
          }
          {
            home-manager.backupFileExtension = "bkp";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./hosts/workstation/home-manager;
            home-manager.extraSpecialArgs = {
              inherit pkgs;
              inherit stateVersion;
              inherit username;
              unstable = import unstable { inherit system; };
              z = z.packages.${system};
            };
            home-manager.sharedModules = [ ./modules/home-manager ];
          }
        ];
      };
    };
}
