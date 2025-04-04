# INFO: Smart and user-friendly command line shell. Includes features like syntax highlighting, autosuggest-as-you-type, and fancy tab completions.
{lib, pkgs, ...}: {
  programs = lib.foldl (acc: program: {
    "${program}" = {
      enable = true;
      enableFishIntegration = true;
    };    
  } // acc) {
    bash = {
      # INFO: Retain Bash as the default shell, but switch to fish when in an interactive shell session. See: https://nixos.wiki/wiki/Fish
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
      shellAbbrs.cl = "clear";
      plugins = ( map
          (plugin: {
            name = "${plugin}";
            inherit (pkgs.fishPlugins."${plugin}") src;
          }) [
          "autopair"
          "bang-bang"
          "colored-man-pages"
          "done"
          "fzf-fish" # TODO: List fzf keybindings into a cheatsheet solution for the terminal
          "pure"
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
        ] ++ [
            {
              name = "fish-abbreviation-tips";
              src = pkgs.fetchFromGitHub {
                owner = "gazorby";
                repo = "fish-abbreviation-tips";
                rev = "dc590a5b9d9d2095f95f7d90608b48e55bea0b0e";
                hash = "sha256-6z3Wr2t8CP85xVEp6UCYaM2KC9PX4MDyx19f/wjHkb0=";
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
    }
  
    # INFO: Additional programs that enhance the experience of using fish
    [
      "navi" # Interactive cheatsheet tool for the command line
      "fzf" # Command line fuzzy finder
      "nix-index" # nix-index, somewhat similar to apt search. INFO: the index needs to be initially built by running "nix-index" with no arguments.
      "zoxide" # Shell agnostic Z directory jumping
    ]
    |> (a: a // {
        mcfly = { # Command history browser
          enable = true;
          enableFishIntegration = true;
          fzf.enable = true;
        };
      });
}
