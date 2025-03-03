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
          deno # required by peek.nvim
          tree-sitter # required to parse text (hence a bunch of stuff)

          R # R support
          cargo # Rust support
          gcc # C support
          gnumake # Make support
          hyprls # Hypr support
          swi-prolog # Prolog support
          tinyxxd # Binary support
          vhdl-ls # VHDL support

          # Latex support
          texlab # Language server
          texliveMedium # Various latex utilities
          texlivePackages.mathtools # Mathematical symbols

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
      extraLuaPackages = ps:
        with ps; [
          luarocks
          neorg
          magick
        ];

      extraPython3Packages = ps:
        with ps; [
          # NOTE: Dependency of the python language package
          wheel
          # NOTE: Dependencies of the Molten plugin
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

  home.sessionVariables = {
    # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [sqlite])}:$LD_LIBRARY_PATH";
  };

  xdg = {
    configFile."nvim".source = with config;
      lib.file.mkOutOfStoreSymlink
      "${pathToModules}/terminal/astronvim/nvim";
    mimeApps.defaultApplications."text/plain" = "nvim.desktop";
  };
}
