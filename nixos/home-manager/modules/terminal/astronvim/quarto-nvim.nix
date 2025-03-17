{pkgs, ...}:
with pkgs; let
  python-with-packages = python3.withPackages python-extra-packages;
in {
  home.packages = [python-with-packages];
  programs.neovim.extraPackages = let
    quarto-with-packages =
      quarto.override
      {
        extraPythonPackages = python-extra-packages;
      };
  in [quarto-with-packages];
}
