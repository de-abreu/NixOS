{...}: {
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland.settings.exec-once = ["hyprpaper"];
}
