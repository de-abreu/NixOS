{pkgs, ...}: {
  programs = {
    # INFO: Retain Bash as the default shell, but switch to fish when in an interactive shell session. See: https://nixos.wiki/wiki/Fish
    bash = {
      enable = true;
      initExtra =
        # bash
        ''
          if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec fish $LOGIN_OPTION
          fi
        '';
    };
    fish = {
      enable = true;
      shellAbbrs = {
        c = "wl-copy";
        cl = "clear";
        co = "wl-paste";
        nv = "nvim";
        snv = "sudoedit";
      };
      plugins = let
        fromRepo = plugins:
          map
          (plugin: {
            name = "${plugin}";
            inherit (pkgs.fishPlugins."${plugin}") src;
          })
          plugins;
      in
        (fromRepo [
          "autopair"
          "bang-bang"
          "colored-man-pages"
          "done"
          "fzf-fish"
          "pure"
          "z"
        ])
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
