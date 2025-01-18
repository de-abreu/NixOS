# INFO: Run unpatched dynamic binaries on NixOS, a requirement to use the Mason package manager
{ ... }: {
  programs.nix-ld.enable = true;
}
