{config, ...}: {
  imports = [./theme.nix];

  programs.hyprpanel = {
    enable = true;
    # Automatically restart HyprPanel whenever its configuration is updated
    systemd.enable = true;
    # Set Hyprland to start Hyprpanel
    hyprland.enable = true;
    # See this option description at
    # https://hyprpanel.com/getting_started/installation.html#home-manager-module
    overwrite.enable = true;

    layout = {
      "bar.layouts" = {
        "0" = {
          left = [
            "dashboard"
            "workspaces"
            "submap"
          ];
          middle = ["media"];
          right = [
            "volume"
            "network"
            "bluetooth"
            "systray"
            "battery"
            "hypridle"
            "clock"
            "notifications"
          ];
        };
      };
    };
    settings = {
      bar = {
        battery.hideLabelWhenFull = true;
        bluetooth.label = false;
        clock = {
          format = "%a %b %d  %H:%M";
          showIcon = false;
        };
        launcher = {
          rightClick = "powermenu";
          icon = "";
        };
        media = {
          show_active_only = true;
          rightClick = "${config.pctl} play-pause";
        };
        customModules.hypridle = {
          label = false;
          rightClick = "screenshot";
        };
      };
      menus = {
        dashboard.shortcuts.left = {
          shortcut1 = {
            icon = "";
            tooltip = "Wezterm";
            command = "wezterm";
          };
          shortcut2 = {
            icon = "";
            tooltip = "Chromium";
            command = "chromium";
          };
          shortcut3 = {
            icon = "";
            tooltip = "Celluloid";
            command = "celluloid";
          };
          shortcut4 = {
            icon = "";
            tooltip = "Launcher";
            command = "launcher";
          };
        };
        clock = {
          time.military = true;
          weather.enabled = false;
        };
      };
      theme = {
        bar = {
          floating = true;
          transparent = true;
          margin_sides = "0px";
          outer_spacing = "15px";
        };
        font = with config.stylix.fonts; {
          name = monospace.name;
          size = "${builtins.toString sizes.applications}px";
        };
      };
      terminal = "$TERMINAL";
    };
  };
}
