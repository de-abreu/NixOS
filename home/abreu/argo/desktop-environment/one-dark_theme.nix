{pkgs, ...}: {
  hydenix.hm.theme = {
    active = "One Dark";
    themes = ["One Dark"];
  };

  stylix = with pkgs; {
    enable = true;
    base16Scheme = "${base16-schemes}/share/themes/onedark.yaml";
    polarity = "dark";

    fonts = {
      serif = {
        package = libre-baskerville;
        name = "LibreBaskerville";
      };
      sansSerif = {
        package = inter;
        name = "Inter";
      };
      monospace = {
        package = nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes.terminal = 10;
    };

    # INFO: Remove items set using HyDE theming
    targets = {
      qt.enable = false;
      gtk.enable = false;
      hyprland.enable = false;
      hyprpaper.enable = false;
      hyprlock.enable = false;
      kitty.enable = false;
      rofi.enable = false;
      waybar.enable = false;
    };
  };
}
