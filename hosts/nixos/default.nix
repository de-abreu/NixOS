{lib, ...}: {
  imports = [../common ./configuration.nix];
  networking.hostName = lib.mkForce "nixos";
}
