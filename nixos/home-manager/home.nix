{
  lib,
  filter,
  userPrefs,
  ...
}: {
  imports = filter ./modules;

  options.pathToModules = lib.mkOption {
    type = lib.types.str;
  };

  config = with userPrefs; {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
    };
    pathToModules = "${flakePath}/nixos/home-manager/modules/";
    programs.home-manager.enable = true;
  };
}
