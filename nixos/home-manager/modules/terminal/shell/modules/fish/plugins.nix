{lib, pkgs, ...} : {
  programs = lib.foldl (acc: program:
    {
      "${program}" = {
        enable = true;
        enableFishIntegration = true;
      };
    }
    // acc) {
        fish = {
          plugins = ( map
            (plugin: {
              name = "${plugin}";
              inherit (pkgs.fishPlugins."${plugin}") src;
            }) [
            "autopair"
            "bang-bang"
            "colored-man-pages"
            "done"
            "fish-bd"
            "fish-you-should-use"
            "fzf-fish" # TODO: List fzf keybindings into a cheatsheet solution for the terminal
            "pure"
            "sponge"
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
          shellInitLast =
            # fish
            ''
              set --universal pure_color_success green
              set --universal pure_enable_nixdevshell true
            '';
        };
    } 
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
