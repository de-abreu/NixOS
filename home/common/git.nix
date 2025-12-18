{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      lfs.enable = true; # Large file storage
    };
    lazygit = {
      enable = true;
      settings.gui.mouseEvents = false;
    };
    fish = {
      shellAbbrs.lg = "lazygit";
      plugins = [
        {
          name = "git-abbr";
          inherit (pkgs.fishPlugins.git-abbr) src;
        }
      ];
    };
  };
}
