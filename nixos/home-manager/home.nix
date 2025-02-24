{
  lib,
  userPrefs,
  ...
}: with userPrefs; {
  imports = map (module: ./modules/ + module) [
    "desktop"
    "terminal"
    "browsers"
    "media"
    "study"
  ];

  options = {
    pathToModules = lib.mkOption {
      type = lib.types.str;
      default = "${flakePath}/nixos/home-manager/modules/";
    };
  };

  config = {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";   
    };

    # WARN: Color scheme overrides
    stylix.targets = {
      fish.enable = false; # Set with fish_theme
      neovim.enable = false; # Managed in astroui.lua
      wezterm.enable = false; # Managed in appearance.lua
      rofi.enable = false; # Managed in theme.rasi
      hyprlock.enable = false;
      waybar.enable = false;
    };

    xdg = {
      enable = true;
      mimeApps.enable = true;
    };
    programs.home-manager.enable = true;
  };
}
