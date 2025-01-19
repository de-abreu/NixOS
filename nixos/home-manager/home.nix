{filter, ...}: {
  home = rec {
    username = "user";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  imports = filter ./modules;
  programs.home-manager.enable = true;
}
