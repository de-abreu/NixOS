{
  outputs,
  lib,
  pkgs,
  experimentalFeatures,
  ...
}: {
  imports = [./git.nix ./xdg.nix];
  nixpkgs.overlays = [outputs.overlays.unstable-packages];
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = experimentalFeatures;
  };
  programs.home-manager.enable = true;
}
