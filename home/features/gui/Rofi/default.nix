# INFO: A floating menu
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./launcher
    ./powermenu
    ./settings
  ];

  config = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      cycle = true;
    };
    xdg.configFile."rofi/theme.rasi".text = with config.lib.stylix.colors; ''
      * {
        background:     #${base00}ff;
        background-alt: #${base01}ff;
        foreground:     #${base07}ff;
        active:         #${base0B}ff;
        selected:       #${base0D}ff;
        urgent:         #${base08}ff;
      }
    '';
    stylix.targets.rofi.enable = false;
  };
}
