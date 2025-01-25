{...}: {
  programs = {
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = true;
    };
    fish.shellAbbrs = {
      ls = "eza";
      tree = "eza --tree";
    };
  };
}
