# INFO: Using stylix to set the system's icon theme
{pkgs, ...}: {
  stylix = {
    # WARN: Color scheme overrides
    targets = {
      fish.enable = false; # Set with fish_theme
      neovim.enable = false; # Managed in astroui.lua
      wezterm.enable = false; # Managed in appearance.lua
      rofi.enable = false; # Managed in theme.rasi
      hyprlock.enable = false;
    };
    iconTheme = {
      enable = true;
      package = pkgs.flat-remix-icon-theme;
      dark = "Flat-Remix-Blue-Dark";
      light = "Flat-Remix-Blue-Light";
    };
  };
}
