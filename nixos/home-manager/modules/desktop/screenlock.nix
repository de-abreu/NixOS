{
  config,
  pkgs,
  ...
}:
with config.lib.stylix; {
  # TODO: Configure lock screen to be less lame.
  # For that, disable stylix's default styling: `stylix.targets.hyprlock.enable = false;`
  # Documentation: https://github.com/danth/stylix/blob/master/modules/hyprlock/hm.nix

  home.packages = [pkgs.brightnessctl];
  wayland.windowManager.hyprland.settings.exec-once = ["hypridle" "hyprlock"];
  programs.hyprlock.enable = true;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Avoid the creation of multiple hyprlock instances
        lock_cmd = "pidof hyprlock || hyprlock";
        # Lock session before suspending
        before_sleep_cmd = "loginctl lock-session";
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
          on-timeout = "loginctl lock-session";
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
