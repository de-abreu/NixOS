# INFO: Smart and user-friendly command line shell. Includes features like syntax highlighting, autosuggest-as-you-type, and fancy tab completions.
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
        cl = "clear";
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
          "fzf-fish" # TODO: List fzf keybindings into a cheatsheet solution for the terminal
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
          fish_config theme choose "ayu Mirage"
          set --universal pure_color_success green
          set --universal pure_enable_nixdevshell true
        '';
    };

    # INFO: Additional programs that enhance the experience of using fish

    # Interractive cheatsheet tool for the command line
    navi = {
      enable = true;
      enableFishIntegration = true;
    };

    # Command line fuzzy finder
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    # History browser
    mcfly = {
      enable = true;
      enableFishIntegration = true;
      fzf.enable = true;
    };

    # nix-index, somewhat similar to apt search
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  # Run commands without having them installed, by prefixing it with a comma. A wrapper for nix shell -c and nix-index
  home.packages = [pkgs.comma];

  stylix.targets.fish.enable = false; # WARN: Managed with fish_theme
}
