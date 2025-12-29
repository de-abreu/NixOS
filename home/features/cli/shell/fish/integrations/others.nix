{lib, ...}: {
  programs =
    lib.foldl' (acc: program:
      {
        "${program}" = {
          enable = true;
          enableFishIntegration = true;
        };
      }
      // acc) {
      mcfly = {
        enable = true;
        enableFishIntegration = true;
        fzf.enable = true;
      };
    } [
      "navi" # Interactive cheatsheet tool for the command line
      "fzf" # Command line fuzzy finder
      "nix-index" # nix-index, somewhat similar to apt search. INFO: the index needs to be initially built by running "nix-index" with no arguments.
      "zoxide" # Shell agnostic Z directory jumping
    ];
}
