{
  description = "Murtaza Udaipurwala's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    z = {
      url = "github:murtaza-u/z/v0.1.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = { nixpkgs, flake-utils, ... }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs; };
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
              lua-language-server
            ];
          };
        }
      )
    //
    {
      nixosConfigurations = {
        primary = mkSystem "primary" rec {
          system = "x86_64-linux";
          user = "murtaza";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = p: builtins.elem (pkgs.lib.getName p) [
              "zoom"
              "steam"
              "steam-unwrapped"
            ];
          };
          hostName = "workstation-primary";
          extraModules = [ inputs.nixos-hardware.nixosModules.common-gpu-intel ];
        };
        secondary = mkSystem "secondary" rec {
          system = "x86_64-linux";
          user = "murtaza";
          pkgs = import nixpkgs { inherit system; };
          hostName = "workstation-secondary";
        };
      };
    };
}
