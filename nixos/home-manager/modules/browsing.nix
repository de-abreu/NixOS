{pkgs, ...}:
with pkgs; {
  programs.chromium = {
    enable = true;
    dictionaries = [hunspellDictsChromium.en_US];
    extensions = [
      # uBlock Origin
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }

      # Bypass Paywalls
      {
        id = "dcpihecpambacapedldabdbpakmachpb";
        updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
      }
    ];
  };
  home.packages = [tor-browser mullvad-browser];
}
