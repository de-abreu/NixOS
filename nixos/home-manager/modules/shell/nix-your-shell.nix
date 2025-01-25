{pkgs, ...}: let
  nys = pkgs.nix-your-shell;
in {
  home.packages = [nys];
  programs.fish.shellInit =
    # fish
    ''
      ${nys} fish | source
    '';
}
