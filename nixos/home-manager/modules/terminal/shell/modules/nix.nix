# INFO: Utilities to aid manipulating Nix
{
  userPrefs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    devenv
    nix-prefetch-git
    nix-your-shell
  ];
  programs = {
    nh = {
      enable = true;
      flake = userPrefs.flakePath;
    };
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    fish = {
      shellInit =
        # fish
        ''
          export DEVENV_CMDLINE=fish
          if command -q nix-your-shell
            nix-your-shell fish | source
          end
        '';
      shellAbbrs = {
        nd = "nix develop";
        ng = "nix-collect-garbage";
        nos = "nh os switch -- --show-trace";
        nr = "nix run";
        ns = "nix shell";
      };
    };
  };
}
