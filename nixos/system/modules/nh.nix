# INFO: Nix Helper, a reimplementation of some of Nix most used commands.
{...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
    flake = "/home/user/.config/NixOS";
  };
}
