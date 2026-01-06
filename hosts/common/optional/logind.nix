# WARN: Allows for DEs to map triggers to the power key
{
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandlepowerKeyLongPress = "poweroff";
  };
}
