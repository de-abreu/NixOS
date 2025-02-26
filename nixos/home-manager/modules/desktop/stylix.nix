{pkgs, ...}: {
  stylix = {
    polarity = "dark";
    iconTheme = {
      enable = true;
      package = pkgs.flat-remix-icon-theme;
      dark = "Flat-Remix-Blue-Dark";
      light = "Flat-Remix-Blue-Light";
    };
  };
}
