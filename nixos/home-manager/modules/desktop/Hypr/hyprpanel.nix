{inputs, ...}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    # Automatically restart HyprPanel whenever its configuration is updated
    systemd.enable = true;
    # Set Hyprland to start Hyprpanel
    hyprland.enable = true;
    # See this option description at
    # https://hyprpanel.com/getting_started/installation.html#home-manager-module
    overwrite.enable = true;
  };
}
