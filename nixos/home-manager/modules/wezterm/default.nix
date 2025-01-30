{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.wezterm = {
    enable = true;
    extraConfig = with colors;
    # lua
      ''
        local config = require("wezterm").config_builder() -- [[@as Wezterm]]

        -- Set leader key
        config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

        -- Import modules
        require("modules.multiplexing").apply_to_config(config)
        require("modules.appearance").apply_to_config(config)
        require("modules.overrides").apply_to_config(config)
        require("modules.rendering").apply_to_config(config)
        require("modules.scrollback-nvim").apply_to_config(config)

        -- Configure tab bar
        config.hide_tab_bar_if_only_one_tab = false
        config.tab_and_split_indices_are_zero_based = true

         -- Display an indicator (🌊) whenever the Leader key is active
        wezterm.on("update-right-status", function(window, _)
          local SOLID_LEFT_ARROW = ""
          local ARROW_FOREGROUND = {
            Foreground = {
              Color = window:active_tab():tab_id() == 0 and "${base01}" or "${base03}"
            }
          }
          local prefix = " "

          if window:leader_is_active() then
            prefix = " " .. utf8.char(0x1f30a) -- Ocean wave
            SOLID_LEFT_ARROW = utf8.char(0xe0b2)
          end

          window:set_left_status(wezterm.format({
            { Background = { Color = "${base0E}" } },
            { Text = prefix },
            ARROW_FOREGROUND,
            { Text = SOLID_LEFT_ARROW },
          }))
        end)
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
