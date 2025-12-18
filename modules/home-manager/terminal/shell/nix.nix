# INFO: Utilities to aid manipulating Nix
{
  inputs,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      devenv
      nix-prefetch-git
      nix-your-shell
    ];
    sessionVariables.DEVENV_CMDLINE = "fish";
  };
  programs = {
    nh = {
      enable = true;
      flake = inputs.self.sourceInfo.outPath;
    };
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    fish = {
      shellInit =
        # fish
        ''
          if command -q nix-your-shell
            nix-your-shell fish | source
          end
        '';
      shellAbbrs = {
        fc = "nix flake check";
        nd = "nix develop";
        ng = "nix-collect-garbage";
        nos = "nh os switch -- --show-trace";
        nr = "nix run";
        ns = "nix shell";
      };
    };
  };
}
