# INFO: Astronvim, an aesthetically pleasing and feature-rich neovim config that
# is extensible and easy to use with a great set of plugins. More languages for
# spellcheck can be found at https://ftp.nluug.nl/pub/vim/runtime/spell/

{
  config,
  pkgs,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages =
        (with pkgs; [
          tree-sitter # required to parse text (hence a bunch of stuff)
          deno # required by peek.nvim

          R # R support
          cargo # Rust support
          gcc # C support
          gnumake # Make support
          hyprls # Hypr support
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
        ])
        ++ (with pkgs.rPackages; [
          languageserversetup
          languageserver
        ]);

      withNodeJs = true;

      # NOTE: Dependencies to enable the image-nvim plugin
      extraLuaPackages = ps: with ps; [luarocks magick];

      # NOTE: If not for `wheel`, these are dependencies of the "Molten" plugin
      extraPython3Packages = ps:
        with ps; [
          wheel
          pynvim
          jupyter-client
          cairosvg
          pnglatex
          plotly
          kaleido
          pyperclip
          nbformat
          pandas
          numpy
          matplotlib
        ];
    };
    fish.shellAbbrs = {
      nv = "nvim";
      snv = "sudoedit";
    };
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.pathToModules}/astronvim/nvim";
}
