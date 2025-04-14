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
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = { nixpkgs, unstable, home-manager, nur, plasma-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "zoom"
          "corefonts"
          "mongodb-compass"
          "obsidian"
          "cursor"
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
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./modules/nixos
          ./hosts/workstation/nixos
          { system.stateVersion = stateVersion; }
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
              z = inputs.z.packages.${system};
            };
            home-manager.sharedModules = [
              ./modules/home-manager
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }
        ];
      };
    };
}
