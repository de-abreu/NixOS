{
  config,
  pkgs,
  ...
}: {
  # TODO: Configure lock screen to be less lame.
  # Documentation: https://github.com/danth/stylix/blob/master/modules/hyprlock/hm.nix

  home.packages = [pkgs.brightnessctl];
  wayland.windowManager.hyprland.settings.exec-once = ["hypridle" "hyprlock"];

  programs.hyprlock = let
    shared = {
      monitor = "eDP-1";
      halign = "right";
      valign = "bottom";
      color = "$label_color";
      shadow_passes = 1;
      shadow_boost = 0.5;
    };
  in {
    enable = true;
    settings = with config.lib.stylix.colors; {
      "$label_color" = "rgb(${base06})";
      "$font" = "JetBrainsMono Nerd Font";

      background = {
        path = "${config.stylix.image}";
      };

      # Password input field
      input-field =
        {
          monitor = "eDP-1";
          size = "250, 50";
          dots_size = 0.1;
          dots_spacing = 0.3;
          dots_center = true;
          outer_color = "rgb(${base03})";
          inner_color = "$label_color";
          font_color = "rgb(${base02})";
          check_color = "rgb(${base0B})";
          fail_color = "rgb(${base08})";
          outline_thickness = 2;
          fade_on_empty = true;
          halign = "center";
          valign = "center";
        }
        // shared;

      label = [
        ( # Clock
          {
            text = "cmd[update:1000] date +\"%H:%M\"";
            font_size = 192;
            font_family = "$font ExtraBold";
            position = "-50, 0";
          }
          // shared
        )
        ( # Day-Month-Date
          {
            text = "cmd[update:1000] date +\"%A, %d %B\"";
            font_size = 36;
            font_family = "$font Bold";
            position = "70, 300";
          }
          // shared
        )
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      "$screenlock" = "pidof hyprlock || hyprlock";
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
