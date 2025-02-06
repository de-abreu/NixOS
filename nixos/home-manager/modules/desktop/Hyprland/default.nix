{
  userPrefs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = with pkgs; {
      # Default applications
      "$term" = "wezterm";
      "$editor" = "nvim";
      "$file" = "nautilus";
      "$browser" = "mullvad-browser";
      "$monitor1" = "eDP-1";
      "$monitor1specs" = "$monitor1, preferred, auto, 1";

      exec-once =
        [
          "dunst"
          "systemctl --user enable --now hyprpolkitagent.service"
          "waybar"
        ]
        ++ (map (type: "wl-paste --type ${type} --watch cliphist store") ["text" "image"]);
      input = with userPrefs.keyboard; {
        kb_layout = layout;
        kb_variant = variant;
        touchpad.natural_scroll = true;
        sensitivity = 1;
      };
      monitor = ["$monitor1specs" ",prefered, auto, 1, mirror, $monitor1"];
      windowrule =
        [
          "opacity 0.8, wezterm"
        ]
        ++ (map (pattern: "float, title:^${pattern}$$") [
          "Calculator"
          "Choose Files"
          "Confirm to replace files"
          "File Operation Progress"
          "Save as"
        ]);
      windowrulev2 = "float, class:^(xdg-desktop-portal-gtk)$$";

      # Aesthetics
      decoration = {
        blur = {
          enabled = true;
          passes = 2;
        };
        rounding = 10;
      };
      bezier = "easeInSine, 0.12, 0, 0.39, 0";
      animation = "border, true, 5, easeInSine";
    };
  };

  home.packages = with pkgs; [
    hyprpolkitagent # A polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
    hyprcursor # Cursor rendering
    hyprpicker # Color picker
    playerctl # Command-line utility to control media players
    libnotify # Send desktop notifications to the notification daemon
  ];
}
