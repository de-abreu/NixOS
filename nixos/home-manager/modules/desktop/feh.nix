# INFO: Minimal image viewer
{...}: {
  programs.feh = {
    enable = true;
  };
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "feh.desktop";
    "image/png" = "feh.desktop";
    "image/gif" = "feh.desktop";
    "image/bmp" = "feh.desktop";
    "image/x-xbitmap" = "feh.desktop";
    "image/x-xpixmap" = "feh.desktop";
    "image/tiff" = "feh.desktop";
    "image/x-portable-pixmap" = "feh.desktop";
    "image/x-portable-graymap" = "feh.desktop";
    "image/x-portable-bitmap" = "feh.desktop";
    "image/svg+xml" = "feh.desktop";
    "image/webp" = "feh.desktop";
  };
}
