{pkgs, ...}: let
  nys = pkgs.nix-your-shell;
in {
  home.packages = [nys];
  programs.fish.shellInit =
    # fish
    ''
      if command -q nix-your-shell
        nix-your-shell fish | source
      end
    '';
}
