{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.celluloid];
  xdg.mimeApps.defaultApplications =
    lib.fold
    (elem: acc: {"video/${elem}" = "celluloid.desktop";} // acc) {} [
      "x-matroska"
      "mp4"
    ];
  programs.obs-studio.enable = true;
}
