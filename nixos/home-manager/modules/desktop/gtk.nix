{pkgs, ...}: {
  gtk = {
    enable = true;

    # NOTE: To see valid variant names that can be used, run:
    # nix build nixpkgs#<pkg to be added>
    # cd result
    # eza --tree --level 3

    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Blue-Dark";
    };
  };
}
