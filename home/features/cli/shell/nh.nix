# INFO: "Nix helper": utilities to aid manipulating Nix
{config, ...}: {
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/.config/NixOS";
  };
}
