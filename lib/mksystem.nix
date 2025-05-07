{ nixpkgs, inputs }:

name:
{ system
, user
, pkgs
, hostName
}:

nixpkgs.lib.nixosSystem {
  inherit system pkgs;

  specialArgs = {
    inherit nixpkgs inputs hostName;
  };

  modules = [
    # home-manager
    inputs.home-manager.nixosModules.home-manager

    # self-managed collection modules
    ../modules/nixos

    # host specific nixos module - where it all begins.
    ../hosts/${name}/nixos

    {
      home-manager.backupFileExtension = "bkp";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ../hosts/${name}/home-manager;
      home-manager.extraSpecialArgs = {
        inherit nixpkgs inputs pkgs system user hostName;
        unstable = import inputs.unstable-nixpkgs { inherit system; };
        z = inputs.z.packages.${system};
      };
      home-manager.sharedModules = [
        ../modules/home-manager
        inputs.plasma-manager.homeManagerModules.plasma-manager
      ];
    }
  ];
}
