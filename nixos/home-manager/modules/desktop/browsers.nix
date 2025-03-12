# INFO: Installs GUI based browsers, with Mullvad as the user's default

{pkgs, ...}:
with pkgs; let
  default = "mullvad-browser";
in{
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
  home = {
    packages = [tor-browser mullvad-browser];
    sessionVariables.BROWSER = default;
  };
  xdg.mimeApps.defaultApplications = let
    application = default + ".desktop";
  in map (mime: {name = mime; value = application;}) [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/chrome"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/xhtml+xml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
  ]
  |> lib.listToAttrs;
}
