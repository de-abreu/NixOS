# INFO: Nix Helper, a reimplementation of some of Nix most used commands.
{flakePath, ...}: {
  programs = {
    nh = {
      enable = true;
      flake = flakePath;
    };
    fish.shellAbbrs.nos = "nh os switch";
  };
}
