# INFO: Astronvim, an aesthetically pleasing and feature-rich neovim config that is extensible and easy to use with a great set of plugins
{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraPackages =
      (with pkgs; [
        # Core functionality
        git # required to fetch plugins
        ripgrep # required for search and replace
        tree-sitter # required to parse text (hence a bunch of stuff)

        # Requirements to fetch and uncompress files
        curl
        gnutar
        gzip
        unzip

        wl-clipboard # Clipboard support in Wayland

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
  };

  # neovim-remote, prevents the creation of recursive nvim sessions
  home = {
    packages = [pkgs.neovim-remote];
    sessionVariables."EDITOR" = "nvr";
  };

  xdg = {
    configFile = {
      "nvim/init.lua".source = ./init.lua;
      "nvim/lua".source = ./lua;

      # NOTE: More languages can be found at https://ftp.nluug.nl/pub/vim/runtime/spell/
      "nvim/spell".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/NixOS/nixos/home-manager/modules/astronvim/spell";
    };
  };
}
