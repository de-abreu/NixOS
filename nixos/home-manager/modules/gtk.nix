{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };

    theme = {
      package = pkgs.matcha-gtk-theme;
      name = "Macha-Dark-Azul";
    };

    iconTheme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Blue-Dark";
    };
  };
}
