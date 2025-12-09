# INFO: Smart and user-friendly command line shell. Includes features like syntax highlighting, autosuggest-as-you-type, and fancy tab completions.
{osConfig, ...}: {
  programs = {
    bash = {
      # INFO: Retain Bash as the default shell, but switch to fish when in an interactive shell session. See: https://nixos.wiki/wiki/Fish
      enable = true;
      initExtra =
        # bash
        ''
          if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec fish $LOGIN_OPTION
          fi
        '';
    };
    fish = {
      enable = true;
      shellInit = let
        secrets = osConfig.sops.secrets;
      in
        # fish
        ''
          fish_config theme choose "ayu Mirage"
          export DEEPSEEK_API_KEY=(cat ${secrets."api_keys/deepseek".path})
          export TAVILY_API_KEY=(cat ${secrets."api_keys/tavily".path})
        '';
      shellAbbrs = {
        cl = "clear";
        md = "mkdir -p";
        ":q" = "exit";
      };
    };
  };
  stylix.targets.fish.enable = false;
}
