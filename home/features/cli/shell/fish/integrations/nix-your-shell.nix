# INFO: Allow for nix shell environments be created using the shell currently
# used, instead of － only －with bash.
{...}: {
  programs = {
    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
