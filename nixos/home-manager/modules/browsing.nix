{pkgs, ...}:
with pkgs; {
  programs.chromium = {
    enable = true;
    dictionaries = [hunspellDictsChromium.en_US];
  };
  home.packages = [tor-browser mullvad-browser];
}
