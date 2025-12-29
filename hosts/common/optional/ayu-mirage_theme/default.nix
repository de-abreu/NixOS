{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = with pkgs; {
    enable = true;
    image = ./old.png;
    base16Scheme = "${base16-schemes}/share/themes/ayu-mirage.yaml";
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
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 20;
    };
    icons = {
      enable = true;
      package = pkgs.flat-remix-icon-theme;
      dark = "Flat-Remix-Blue-Dark";
      light = "Flat-Remix-Blue-Light";
    };
    targets.qt.enable = true;
    targets.grub.useWallpaper = true;
  };
}
