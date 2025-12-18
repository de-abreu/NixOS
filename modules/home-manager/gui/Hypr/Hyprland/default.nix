{
  osConfig,
  pkgs,
  ...
}: {
  imports = [./keybinds.nix];

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        "$monitor1" = "eDP-1";
        "$monitor1specs" = "$monitor1, preferred, auto, 1";
        exec-once = ["systemctl --user enable --now hyprpolkitagent.service"];
        monitor = ["$monitor1specs" ",prefered, auto, 1, mirror, $monitor1"];
        general.resize_on_border = true;

        input = with osConfig.services.xserver.xkb; {
          kb_layout = layout;
          kb_variant = variant;
          touchpad.natural_scroll = true;
          sensitivity = 1;
        };

        windowrule = map (pattern: "float, title:^${pattern}$$") [
          "Calculator"
          "Choose Files"
          "Confirm to replace files"
          "File Operation Progress"
          "Save as"
        ];
        windowrulev2 = "float, class:^(xdg-desktop-portal-gtk)$$";

        # Aesthetics
        decoration = {
          blur = {
            enabled = true;
            passes = 2;
          };
          rounding = 5;
        };
        bezier = "easeInSine, 0.12, 0, 0.39, 0";
        animation = "border, true, 5, easeInSine";
      };
    };

    home.packages = with pkgs; [
      hyprpolkitagent # A polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
      hyprcursor # Cursor rendering
    ];
  };
}
