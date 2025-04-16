{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.celluloid];
  xdg.mimeApps.defaultApplications =
    lib.fold
    (n: acc: {"video/${n}" = "celluloid.desktop";} // acc) {} [
      "x-matroska"
      "mp4"
    ];
}
