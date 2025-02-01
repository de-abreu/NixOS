# INFO: Screen locker
{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
  };
  home.packages = [pkgs.swaylock-fancy];
}
