# INFO: Astronvim, an aesthetically pleasing and feature-rich neovim config that is extensible and easy to use with a great set of plugins
{
  config,
  pkgs,
  ...
}: {
  programs.neovim.enable = true;

  home = {
    packages =
      (with pkgs; [
        # Core functionality
        git # required to fetch plugins
        ripgrep # required for search and replace
        tree-sitter # required to parse text (hence a bunch of stuff)

        cargo # Rust support
        gcc # C support
        gnumake # Make support
        lua # Lua support
        nodejs # Javascript support
        python3 # Python support
        python312Packages.wheel
        swi-prolog # Prolog compiler and interpreter
        tinyxxd # Binary support
        vhdl-ls # VHDL language server

        # Nix support
        nixd # Language server
        alejandra # Formatter
        deadnix # Unused code detection
        statix # Linter and suggestions

        # Haskell support
        haskell-language-server # Language server
        ghc # Compiler
      ])
      ++ (with pkgs.haskellPackages; [
        hoogle # API to search for functions
        fast-tags # Incremental tags
        haskell-debug-adapter # Debug adapter
        ghci-dap
        haskell-dap
      ]);
    sessionVariables."EDITOR" = "nvr -s";
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/NixOS/nixos/home-manager/modules/astronvim/nvim";
  # NOTE: More languages for spellcheck can be found at https://ftp.nluug.nl/pub/vim/runtime/spell/
}
