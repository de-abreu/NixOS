# INFO: Astronvim, an aesthetically pleasing and feature-rich neovim config that is extensible and easy to use with a great set of plugins
{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages =
      (with pkgs; [
        # Core functionality
        git # required to fetch plugins
        ripgrep # required for search and replace
        tree-sitter # required to parse text (hence a bunch of stuff)
        neovim-remote # Prevents the recursive creation of Neovim sessions

        # Requirements to fetch and uncompress files
        curl
        gnutar
        gzip
        unzip

        wl-clipboard # Clipboard support in Wayland

        lua # Lua support
        cargo # Rust support
        tinyxxd # Binary support
        python3 # Python support
        python312Packages.wheel
        nodejs # Javascript support
        swi-prolog # Prolog compiler and interpreter
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
  };

  home.sessionVariables."EDITOR" = "nvr";

  xdg = {
    configFile = {
      "nvim/init.lua" = {
        source = ./init.lua;
        force = true;
      };
      "nvim/lua" = {
        source = ./lua;
        force = true;
      };
    };
  };

  # NOTE: dictionaries are found under nvim/spell. More languages can be found at https://ftp.nluug.nl/pub/vim/runtime/spell/
}
