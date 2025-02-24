{pkgs, ...}: {
  home.packages = with pkgs; [anki evince libreoffice-still zotero];
  xdg.mimeApps.desktopApplications."application/pdf" = "evince.desktop";
}
