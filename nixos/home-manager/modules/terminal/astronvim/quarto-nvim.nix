{pkgs, ...}:
with pkgs; let
  # WARN: Temporary installation of graphical libraries
  python-extra-packages = ps: with ps; [numpy matplotlib];
in {
  # home.packages = let
  #   python-with-packages = python3.withPackages python-extra-packages;
  # in [python-with-packages];
  programs.neovim.extraPackages = let
    quarto-with-packages =
      quarto.override
      {
        extraPythonPackages = python-extra-packages;
      };
  in [quarto-with-packages];
}
