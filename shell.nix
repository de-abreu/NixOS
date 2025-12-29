{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git

      eza
      sops
      ssh-to-age
      gnupg
      age
    ];
  };
}
