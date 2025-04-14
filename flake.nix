{
  description = "Murtaza Udaipurwala's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    z = {
      url = "github:murtaza-u/z/v0.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit nixpkgs inputs;
      };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              nixd
              gnumake
            ];
          };
        }
      )
    //
    {
      nixosConfigurations.workstation = mkSystem "workstation" rec {
        system = "x86_64-linux";
        user = "murtaza";
        pkgs = import nixpkgs { inherit system; };
      };
    };
}
