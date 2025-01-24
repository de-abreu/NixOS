{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [wezterm];
    sessionVariables."TERM" = "wezterm";
  };
  xdg.configFile."wezterm".source = config.lib.file.mkOutOfStoreSymlink "${config.pathToModules}/wezterm/wezterm";
}
