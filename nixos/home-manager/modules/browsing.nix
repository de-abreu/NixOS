# INFO: Enable privacy enchanced Firefox forks
{pkgs, ...}: {
  programs.librewolf.enable = true;
  home.packages = [pkgs.tor-browser];
}
