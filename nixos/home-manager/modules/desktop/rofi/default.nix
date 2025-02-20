# INFO: Application launcher
{ config, pkgs, userPrefs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    pass = {
      enable = true;
      package = pkgs.rofi-pass-wayland;
    };
    terminal = userPrefs.defaultApplications.term;
    theme = {
      "*" = with config.lib.stylix.colors; {
        background = "#${base00}FF";
        background-alt = "#${base01}FF";
        selected = "#${base02}FF";
        foreground = "#${base07}FF";
        active = "#${base0C}FF";
        urgent = "#${base08}FF";
      };
    };
  };
  xdg.configFile."rofi/launcher.rasi".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.pathToModules}/desktop/rofi/launcher.rasi";
}
