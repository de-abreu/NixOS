{pkgs, ...}:
with pkgs; {
  stylix = {
    enable = true;
    image = ./wallpapers/old.png;
    base16Scheme = "${base16-schemes}/share/themes/ayu-mirage.yaml";
    fonts = {
      serif = {
        package = libre-baskerville;
        name = "LibreBaskerville-Regular";
      };
      sansSerif = {
        package = inter;
        name = "Inter";
      };
      monospace = {
        package = jetbrains-mono;
        name = "JetBrainsMono-Regular";
      };
      emoji = {
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
