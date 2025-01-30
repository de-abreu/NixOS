{...}: {
  programs.hyperland.enable = true;
  environment.sessionVariables."NIXOS_OZONE_WL" = "1";
}
