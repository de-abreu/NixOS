# INFO: Run unpatched dynamic binaries on NixOS, a requirement to use the Mason package manager
{ pkgs, ... }: {
  programs.nix-ld = { 
    enable = true;
    libraries = [ pkgs.icu ]; # Required by the marksman LSP
  };
}
