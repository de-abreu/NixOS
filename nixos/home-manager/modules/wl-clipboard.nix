{pkgs, ...}: {
  home.packages = [pkgs.wl-clip-persist];
  programs.fish.shellAbbrs = {
    c = "wl-copy";
    co = "wl-paste";
  };
}
