{
  config,
  lib,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.wezterm = {
    enable = true;
    extraConfig = with colors; let
      imports = with lib; map (module: "require(\"modules.${elemAt module 0}\").apply_to_config(${elemAt module 1})") [
        ["keybinds.overrides" "config"]
        ["keybinds.panes-and-tabs" "config"]
        ["appearance" "config, colortheme"]
        ["multiplexing" "config"]
        ["rendering" "config"]
        ["scrollback-nvim" "config"]
      ]
      |> (a: a ++ ["require(\"modules.tab-bar\").draw()"])
      |> concatStringsSep "\n";
    in
      # lua
      ''
        local config = require("wezterm").config_builder() -- [[@as Wezterm]]
        local colortheme = {
          background = "${base0D}",
          cursor = "${base07}",
          tab = {
            active = "${base01}",
            inactive = "${base03}"
          },
        }

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
