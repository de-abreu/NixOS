{ pkgs, ... }: {
  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        c = "wl-copy";
        cl = "clear";
        co = "wl-paste";
        nv = "nvr";
        nvim = "nvr";
        snv = "sudoedit";
      };
      plugins =
        let
          fromRepo = plugins:
            map
              (plugin: {
                name = "${plugin}";
                src = pkgs.fishPlugins."${plugin}".src;
              })
              plugins;
        in
        (fromRepo [ "autopair" "bang-bang" "bass" "colored-man-pages" "done" "fzf-fish" "z" ])
        ++ [
          {
            name = "fish-ssh-agent";
            src = pkgs.fetchFromGitHub {
              owner = "danhper";
              repo = "fish-ssh-agent";
              rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
              hash = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
            };
          }
        ];
      shellInit =
        # fish
        ''
          bass source ~/.profile
          set --universal pure_color_success green
          fish_config theme choose "ayu Mirage"
        '';
    };

    # INFO: Additional programs to enhance the experience of using fish
    navi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
