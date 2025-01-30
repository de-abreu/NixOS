{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enableXdgAutostart = true;
      variables = ["--all"];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
    xdgOpenUsePortal = true;
  };

  home.packages = with pkgs; [
    hyprcursor # Cursor rendering
    hyprpicker # Color picker
  ];
}
