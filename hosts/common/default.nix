{
  inputs,
  lib,
  outputs,
  experimentalFeatures,
  ...
}: {
  imports = [
    ./global
    ./optional
    ./users
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [outputs.overlays.unstable-packages];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs experimentalFeatures;};
  };

  nix = {
    settings = {
      experimental-features = experimentalFeatures;

      # NOTE: This sets the users that are allowed to use the flake command
      trusted-users = lib.mkForce ["root" "@wheel"];
    };

    # NOTE: The following takes flakes described as input parameters and makes
    # them globally available to the system. **I'm still not sure why this could
    # necessary**.
    registry = with lib;
      inputs
      |> filterAttrs (_: isType "flake")
      |> mapAttrs (_: flake: {inherit flake;});

    # NOTE: When using flakes, many older tools or scripts might still rely on
    # the NIX_PATH mechanism. Setting this option ensures that our NixOS
    # configuration is compatible with code that uses the older <name> syntax
    # (e.g., import <nixpkgs> {}).
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
  users.mutableUsers = false;
}
