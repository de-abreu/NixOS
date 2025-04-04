# INFO: Utilities to aid manipulating Nix
{
  userPrefs,
  pkgs,
  ...
}: {
  home.packages = [pkgs.nix-prefetch-git];
  programs = {
    nh = {
      enable = true;
      flake = userPrefs.flakePath;
    };
    fish.shellAbbrs = {
      nd = "nix develop";
      nos = "nh os switch -- --show-trace";
    };
  };
}
