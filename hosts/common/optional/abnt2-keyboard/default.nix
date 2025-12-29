{lib, ...}:
with lib; {
  imports = optional (pathExists ./kanata.nix) ./kanata.nix;

  services.xserver.xkb = {
    layout = mkForce "br";
    variant = mkForce "";
  };

  console.keyMap = mkForce "br-abnt2";
}
