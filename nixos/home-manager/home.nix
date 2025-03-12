{
  lib,
  userPrefs,
  ...
}:
with userPrefs; {
  imports = [./modules];

  options = {
    pathToModules = lib.mkOption {
      type = lib.types.str;
      default = "${flakePath}/nixos/home-manager/modules/";
    };
  };

  config = {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
    };

    xdg = {
      enable = true;
      configFile."mimeapps.list".force = true;
      mimeApps.enable = true;
    };
    programs.home-manager.enable = true;
  };
}
