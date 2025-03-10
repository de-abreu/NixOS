# INFO: Minimal image viewer
{lib, ...}: {
  programs.feh = {
    enable = true;
    keybindings = {
      prev_img = "j";
      next_img = "ç";
    };
  };
  xdg.mimeApps.defaultApplications =
    lib.fold
    (n: acc: {"image/${n}" = "feh.desktop";} // acc) {} [
      "bmp"
      "gif"
      "jpeg"
      "png"
      "sxg+xml"
      "tiff"
      "webp"
      "x-portable-bitmap"
      "x-portable-graymap"
      "x-portable-pixmap"
      "x-xbitmap"
      "x-xpixmap"
    ];
}
