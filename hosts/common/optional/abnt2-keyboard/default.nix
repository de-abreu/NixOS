{lib, ...}:
with lib; {
  imports = optional (pathExists ./kanata.nix) ./kanata.nix;
  console.keyMap = "br-abnt2";
}
