{...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };
  home.sessionVariables.FILEBROWSER = "yazi";
  xdg.mimeApps.defaultApplications."inode/directory" = "yazi.desktop";
}
