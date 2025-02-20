{...}: {
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland.settings = {
    exec-once = ["systemctl --user enable --now hyprpaper.service"];
    misc.disable_hyprland_logo = true; # Disable hyprland's default wallpapers
  };
}
