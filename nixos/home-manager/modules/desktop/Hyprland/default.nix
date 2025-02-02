{
  userPrefs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = with pkgs; {
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
      monitor = ["eDP-1,preferred, auto, 1" ",prefered, auto, 1, mirror, eDP-1"];
      windowrule =
        [
          "opacity 0.8, wezterm"
        ]
        ++ (map (pattern: "float, title:^${pattern}$$") [
          "Choose Files"
          "Save as"
          "Confirm to replace files"
          "File Operation Progress"
        ]);
      windowrulev2 = "float, class:^(xdg-desktop-portal-gtk)$$";

      # Default applications
      "$term" = "wezterm";
      "$editor" = "nvim";
      "$file" = "nautilus";
      "$browser" = "mullvad-browser";

      # Aesthetics
      decoration = {
        blur.enabled = true;
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
