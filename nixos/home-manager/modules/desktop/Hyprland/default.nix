{
  config,
  pkgs,
  ...
}: let
  hyprPath = "${config.pathToModules}/desktop/Hyprland/";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    sourceFirst = false;
    extraConfig = ''
      # █▀ █▀█ █░█ █▀█ █▀▀ █▀▀
      # ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄
    '';
    settings = {
      "$modules" = "~/.config/hypr/modules";
      "source" = [
        "$modules/inputs.conf"
        "$modules/keybindings.conf"
        "$modules/launch.conf"
        "$modules/monitors.conf"
        "$modules/userprefs.conf"
        "$modules/windowrules.conf"
      ];
    };
  };

  home.packages = with pkgs; [
    hyprpolkitagent # A polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
    hyprcursor # Cursor rendering
    hyprpicker # Color picker
    playerctl # Command-line utility to control media players
    libnotify # Send desktop notifications to the notification daemon
  ];

  xdg.configFile = {
    "hypr/modules" = config.lib.file.mkOutOfStoreSymlink "${hyprPath}/modules";
  };
}
