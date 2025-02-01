{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  currentPath = "${config.pathToModules}/desktop/Hyprland/";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings."source" = map (path: "modules/" + (baseNameOf (toString path))) (fileset.toList ./modules);
  };

  home.packages = with pkgs; [
    hyprpolkitagent # A polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
    hyprcursor # Cursor rendering
    hyprpicker # Color picker
    playerctl # Command-line utility to control media players
    libnotify # Send desktop notifications to the notification daemon
  ];

  xdg.configFile = {
    "hypr/modules".source = config.lib.file.mkOutOfStoreSymlink "${currentPath}/modules";
    "hypr/colors.conf".text = with config.lib.stylix; let
      bases = map (count: "base0" + (toHexString count)) (range 0 15);
    in
      concatStringsSep "\n" (
        map (base: "\$${base} = rgb(${getAttr base colors})") bases
      );
  };
}
