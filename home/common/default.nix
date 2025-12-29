{inputs, ...}: {
  imports = [
    ./git.nix
    ./xdg.nix
  ];
  programs.home-manager.enable = true;
}
