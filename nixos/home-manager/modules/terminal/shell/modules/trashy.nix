{pkgs, ...}: {
  home.packages = [pkgs.trashy];
  programs.fish.shellAbbrs.rm = "trash";
}
