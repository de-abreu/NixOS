# FIX: Remove this package when switching from nvim to nixvim
{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = [pkgs.icu]; # Required by the marksman LSP
  };
}
