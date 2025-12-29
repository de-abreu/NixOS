# INFO: Smart and user-friendly command line shell. Includes features like syntax highlighting, autosuggest-as-you-type, and fancy tab completions.
{config, ...}: {
  imports = [./integrations ./plugins.nix ./theming.nix];

  programs = {
    fish = {
      enable = true;
      shellInit = let
        secrets = config.sops.secrets;
      in
        # fish
        ''
          export DEEPSEEK_API_KEY=(cat ${secrets."api-keys/deepseek".path})
          export TAVILY_API_KEY=(cat ${secrets."api-keys/tavily".path})
        '';
      shellAbbrs = {
        cl = "clear";
        md = "mkdir -p";
        ":q" = "exit";

        fc = "nix flake check";
        nd = "nix develop";
        ng = "nix-collect-garbage";
        nos = "nh os switch -- --show-trace";
        nr = "nix run";
        ns = "nix shell";
      };
    };
  };
  stylix.targets.fish.enable = false;
}
