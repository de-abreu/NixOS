{
  userPrefs,
  pkgs,
  ...
}: {
  programs = {
    git = with userPrefs.git; {
      enable = true;
      userName = userName;
      userEmail = userEmail;
      extraConfig = {
        commit.gpgsign = true;
        tag.gpgsign = true;
        user.signingkey = signingkey;
      };
    };
    lazygit = {
      enable = true;
      settings = {
        gui.mouseEvents = false;
        keybinding.universal = {
          prevItem-alt = "l";
          nextItem-alt = "k";
          scrollLeft = "J";
          scrollRight = "Ç";
          prevBlock-alt = "j";
          nextBlock-alt = "ç";
          scrollUpMain-alt1 = "L";
          scrollDownMain-alt1 = "K";
        };
      };
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
