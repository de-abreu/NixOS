{...}: {
  programs = {
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = "auto";
    };
    fish.shellAbbrs = {
      ls = "eza";
      tree = "eza --tree";
    };
  };
}
