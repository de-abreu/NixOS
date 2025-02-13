{pkgs, ...}:
with pkgs; {
  stylix = {
    enable = true;
    image = ./wallpapers/old.png;
    base16Scheme = "${base16-schemes}/share/themes/ayu-mirage.yaml";
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
        package = nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes.terminal = 10;
    };
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 20;
    };
    targets.grub.useImage = true;
  };
}
