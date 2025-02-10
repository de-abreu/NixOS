{
  config,
  lib,
  ...
}: {
  stylix.targets.wezterm.enable = false; # WARN: Managed by AstroUI
  programs.wezterm = {
    enable = true;
    extraConfig = let
      imports = with lib; map (module: "require(\"modules.${module}\").apply_to_config(config)") [
        "appearance"
        "keybinds.overrides"
        "keybinds.panes-and-tabs"
        "multiplexing"
        "rendering"
        "scrollback-nvim"
        "tab-bar"
      ]
      |> concatStringsSep "\n";
    in
      # lua
      ''
        local config = require("wezterm").config_builder() -- [[@as Wezterm]]
        
        ${imports}

        return config
      '';
  };
  home.sessionVariables."TERM" = "wezterm";
  xdg = {
    configFile."wezterm/modules".source = config.lib.file.mkOutOfStoreSymlink "${config.pathToModules}/wezterm/modules";
    mimeApps = {
      enable = true;
      defaultApplications."application/x-terminal-emulator" = ["wezterm.desktop"];
    };
  };
}
