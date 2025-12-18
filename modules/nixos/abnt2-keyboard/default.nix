{lib, ...}:
with lib; {
  imports =
    if builtins.pathExists ./kanata.nix
    then [./kanata.nix]
    else []; # Added customization using kanata

  services.xserver.xkb = {
    layout = mkForce "br";
    variant = mkForce "";
  };

  console.keyMap = mkForce "br-abnt2";
}
