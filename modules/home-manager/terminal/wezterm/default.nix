{
  config,
  lib,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = let
      imports = with lib;
        foldl (acc: elem: acc + "require(\"modules.${elem}\").apply_to_config(config)\n")
        # Lua
        ''require("appearance").apply_to_config(config)''
        [
          "keybinds.overrides"
          "keybinds.panes-and-tabs"
          "multiplexing"
          "rendering"
          "scrollback-nvim"
          "tab-bar"
        ];
    in
      # lua
      ''
        local config = wezterm.config_builder() -- [[@as Wezterm]]
        ${imports}
        return config
      '';
  };
  xdg = {
    configFile = {
      "wezterm/appearance.lua".text = with config.lib.stylix.colors;
      with config.stylix.fonts;
      # lua
        ''
          local wezterm = require("wezterm")
          local module = {}

          function module.apply_to_config(config)
            -- Colorscheme
            local theme = "Ayu Mirage"
            local custom = wezterm.color.get_builtin_schemes()[theme]
            custom.background = "${base00}"
            custom.cursor_bg = "${base07}"
            custom.tab_bar = {
            background = "${base01}",
              new_tab = {
                bg_color = "${base01}",
                fg_color = "${base07}",
              },
            }
            custom.cursor_border = custom.cursor_bg
            config.color_schemes = { [theme] = custom }
            config.color_scheme = theme

            -- Font settings
            config.warn_about_missing_glyphs = false
            config.font = wezterm.font_with_fallback {
              "${monospace.name}",
              "${emoji.name}",
            }
            config.font_size = ${builtins.toString sizes.terminal}
            config.line_height = 1.2

            -- Windows and tabs
            config.window_decorations = "NONE"
            config.tab_bar_at_bottom = true
            config.use_fancy_tab_bar = false
            config.hide_tab_bar_if_only_one_tab = false
          end

          return module
        '';

      "wezterm/modules".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.config/NixOS/terminal/wezterm/modules";
    };
    mimeApps.defaultApplications."application/x-terminal-emulator" = "wezterm.desktop";
  };
  wayland.windowManager.hyprland.settings = {
    "$terminal" = "wezterm";
    windowrule = ["opacity 0.8, class:org.wezfurlong.wezterm"];
  };
  home.sessionVariables.TERMINAL = "wezterm";
  dconf.settings."org/gnome/desktop/default-applications/terminal".exec = "wezterm";
  stylix.targets.wezterm.enable = false; # Managed in appearance.lua
}
