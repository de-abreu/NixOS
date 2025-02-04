{...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  services.logind = {
    powerKey = "ignore"; # WARN: Allows for Hyprland decide what to do when this key is pressed.
    powerKeyLongPress = "poweroff";
  };
  environment.sessionVariables."NIXOS_OZONE_WL" = "1";
}
