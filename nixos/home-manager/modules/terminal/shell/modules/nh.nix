# INFO: Nix Helper, a reimplementation of some of Nix most used commands.
{userPrefs, ...}: {
  programs = {
    nh = {
      enable = true;
      flake = userPrefs.flakePath;
    };
    fish.shellAbbrs.nos = "nh os switch -- --show-trace";
  };
}
