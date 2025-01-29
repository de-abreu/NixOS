{
  lib,
  filter,
  username,
  flakePath,
  ...
}: {
  imports = filter ./modules;

  options.pathToModules = lib.mkOption {
    type = lib.types.str;
  };

  config = {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
    };
    pathToModules = "${flakePath}/nixos/home-manager/modules/";
    # stylix.targets = {
    #   # WARN:
    #   neovim.enable = false; # Managed with AstroUI
    #   fish.enable = false; # Managed with fish_theme
    # };
    programs.home-manager.enable = true;
  };
}
