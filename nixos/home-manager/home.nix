{
  config,
  lib,
  filter,
  username,
  ...
}: {
  imports = filter ./modules;

  options.pathToModules = lib.mkOption {
    type = lib.types.str;
  };

  config = {
    home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
    };
    pathToModules = "${config.home.homeDirectory}/.config/NixOS/nixos/home-manager/modules/";
    programs.home-manager.enable = true;
  };
}
