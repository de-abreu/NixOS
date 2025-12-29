{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  services.logind.settings.Login = {
    HandlePowerKey = "ignore"; # WARN: Allows for Hyprland decide what to do when this key is pressed.
    HandlepowerKeyLongPress = "poweroff";
  };
  environment.sessionVariables."NIXOS_OZONE_WL" = "1";
}
