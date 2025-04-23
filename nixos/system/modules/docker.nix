{userPrefs, ...}: {
  users.users.${userPrefs.username}.extraGroups = ["docker"];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
