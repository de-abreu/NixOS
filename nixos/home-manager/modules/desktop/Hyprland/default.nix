{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprPath = "${config.pathToModules}/desktop/Hyprland/";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$modules" = "~/.config/hypr/modules";
      "source" = with lib; map (p: "$modules/" + p) (map (p: baseNameOf (toString p)) (fileset.toList ./modules));
    };
  };

  home.packages = with pkgs; [
    hyprpolkitagent # A polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
    hyprcursor # Cursor rendering
    hyprpicker # Color picker
    playerctl # Command-line utility to control media players
    libnotify # Send desktop notifications to the notification daemon
  ];

  xdg.configFile."hypr/modules".source = config.lib.file.mkOutOfStoreSymlink "${hyprPath}/modules";
}
