# INFO: Application launcher
{ config, lib, pkgs, userPrefs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    pass = {
      enable = true;
      package = pkgs.rofi-pass-wayland;
    };
    terminal = userPrefs.defaultApplications.term;
  };
  xdg.configFile = {
    "rofi/launcher.rasi".source = config.lib.file.mkOutOfStoreSymlink 
      "${config.pathToModules}/desktop/rofi/launcher.rasi";
    "rofi/theme.rasi".text = with lib; with config.lib.stylix.colors; ''      
      * {
        active:         #${base00}ff;
        background:     #${base01}ff;
        background-alt: #${base02}ff;
        foreground:     #${base07}ff;
        selected:       #${base0D}ff;
        urgent:         #${base08}ff;
      }
    '';
  };
}
