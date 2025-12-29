# INFO: Update the NixOS weekly,
{
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };
}
