{pkgs, ...}:
with pkgs; {
  programs.chromium = {
    enable = true;
    dictionaries = [hunspellDictsChromium.en_US];
  };
  home.sessionVariables."BROWSER" = "mullvad-browser";
  home.packages = [tor-browser mullvad-browser];
}
