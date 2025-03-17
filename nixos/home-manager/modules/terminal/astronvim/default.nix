# INFO: Astronvim, an aesthetically pleasing and feature-rich neovim config that
# is extensible and easy to use with a great set of plugins. More languages for
# spellcheck can be found at https://ftp.nluug.nl/pub/vim/runtime/spell/
# TODO: Solve this mess of a monolithic file
{
  config,
  pkgs,
  ...
}: {
  imports = [./quarto-nvim.nix];

  config = {
    programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; let
          R-with-packages =
            rWrapper.override
            {
              packages = with rPackages; [
                ggplot2
                languageserver
                languageserversetup
                tinytex
              ];
            };
          tex-with-packages = texliveMedium.withPackages (ps:
            with ps; [
              biblatex
              csquotes
              mathtools
            ]);
        in
          [
            deno # required by peek.nvim
            tree-sitter # required to parse text (hence a bunch of stuff)
            emacs # Required by vhdl formatter

            # Language support
            R-with-packages # R
            cargo # Rust
            gcc # C
            gnumake # Make
            hyprls # Hypr
            sqls # SQL language server
            sqlfluff # SQL linter and formatter
            swi-prolog # Prolog
            tinyxxd # Binary
            vhdl-ls # VHDL

            # Latex support
            texlab # Language server
            tex-with-packages # Texlive environment

            # Nix support
            nixd # Language server
            alejandra # Formatter
            deadnix # Unused code detection
            statix # Linter and suggestions

            # Haskell support
            haskell-language-server # Language server
            ghc # Compiler
          ]
          ++ (with pkgs.haskellPackages; [
            hoogle # API to search for functions
            fast-tags # Incremental tags
            haskell-debug-adapter # Debug adapter
            ghci-dap
            haskell-dap
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

    # Fixes the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
    home.sessionVariables.LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [sqlite])}:$LD_LIBRARY_PATH";

    xdg = {
      configFile."nvim".source = with config;
        lib.file.mkOutOfStoreSymlink
        "${pathToModules}/terminal/astronvim/nvim";
      mimeApps.defaultApplications."text/plain" = "nvim.desktop";
    };
  };
}
