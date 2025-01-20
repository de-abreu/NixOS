{config, ...}: {
  programs.wezterm.enable = true;
  xdg.configFile."wezterm".source = config.lib.file.mkOutOfStoreSymlink "${config.pathToModules}/wezterm/wezterm";
}
