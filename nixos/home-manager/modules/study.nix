{pkgs, ...}: {
  home.packages = with pkgs; [anki evince libreoffice-still zotero];
  xdg.mimeApps.defaultApplications."application/pdf" = "evince.desktop";
}
