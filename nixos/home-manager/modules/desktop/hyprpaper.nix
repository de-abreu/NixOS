{...}: {
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland.settings.exec-once = ["systemctl --user enable --now hyprpaper.service"];
}
