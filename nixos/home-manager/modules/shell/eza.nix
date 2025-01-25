{...}: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = true;
  };
  programs.fish.shellAbbrs.ls = "eza";
}
