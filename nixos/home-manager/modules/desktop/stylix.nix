# INFO: Using stylix to set the system's icon theme
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
