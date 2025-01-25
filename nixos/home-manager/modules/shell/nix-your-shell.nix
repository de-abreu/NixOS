{pkgs, ...}: {
  home.packages = [pkgs.nix-your-shell];
  programs.fish.shellInit =
    # fish
    ''
      if command -q nix-your-shell
        nix-your-shell fish | source
      end
    '';
}
