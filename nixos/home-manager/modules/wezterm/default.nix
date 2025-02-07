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
      imports = with lib; fold (elem: acc: ["require(\"modules.${elem}\").apply_to_config(config)"] ++ acc) ["require(\"modules.tab-bar\").apply_to_config(config, colortheme)"] [
        "keybinds.overrides"
        "keybinds.panes-and-tabs"
        "appearance"
        "multiplexing"
        "rendering"
        "scrollback-nvim"
      ] |> concatStringsSep "\n";
    in
      # lua
      ''
        local config = require("wezterm").config_builder() -- [[@as Wezterm]]
        local colortheme = {
          background = "${base0D}",
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
