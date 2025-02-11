{
  config,
  pkgs,
  ...
}: {
  # TODO: Configure lock screen to be less lame.
  # Documentation: https://github.com/danth/stylix/blob/master/modules/hyprlock/hm.nix

  home.packages = [pkgs.brightnessctl pkgs.material-icons];
  wayland.windowManager.hyprland.settings.exec-once = ["hypridle" "hyprlock"];

  programs.hyprlock = {
    enable = true;
    settings = with config.lib.stylix; let
      shared = {
        color = "$text_color";
        monitor = "eDP-1";
        font_family = "${config.stylix.fonts.sansSerif.name}";
        halign = "center";
        valign = "center";
      };
    in {
      "$check_color" = "rgb(${colors.base0B})";
      "$fail_color" = "rgb(${colors.base08})";
      "$label_color" = "rgb(${colors.base07})";
      "$outer_color" = "rgb(${colors.base03})";
      "$text_color" = "rgb(${colors.base01})";
      "$material_icons" = "Material symbols Rounded";

      background = {
        path = "${config.stylix.image}";
      };

      # Password input field
      input-field =
        {
          size = "250, 50";
          dots_size = 0.1;
          dots_spacing = 0.3;
          dots_center = true;
          outer_color = "$outer_color";
          inner_color = "$label_color";
          font_color = "$text_color";
          fade_on_empty = true;
          position = "0, -225";
        }
        // shared;

      label = [
        # Clock
        (
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%H:%M\")\"";
            color = "$label_color";
            shadow_passes = 1;
            shadow_boost = 0.5;
            font_size = 120;
            position = "0, 300";
          }
          // shared
        )
        # Day-Month-Date
        (
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%A, %d %B\")\"";
            color = "$label_color";
            font_size = 36;
            position = "0, 105";
          }
          // shared
        )
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Avoid the creation of multiple hyprlock instances
        lock_cmd = "$screenlock";
        # Lock session before suspending
        before_sleep_cmd = "$screenlock";
        # Avoid having t press a key twice to turn on the display
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Turn off keyboard backlight
        {
          timeout = 240; # 4 minutes, given in seconds
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        # Reduce screen brightness
        {
          timeout = 240;
          on-timeout = "brightnessctl -s set 10"; # Set to minimum
          on-resume = "brightnessctl -r"; # Restore previous value
        }
        # Lock screen
        {
          timeout = 300;
          on-timeout = "$screenlock";
        }
        # Turn screen off after it has been locked
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # Send computer into suspension
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
