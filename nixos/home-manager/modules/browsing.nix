{pkgs, ...}:
with pkgs; {
  programs.chromium = {
    enable = true;
    dictionaries = [hunspellDictsChromium.en_US];
  };
  home = {
    packages = [tor-browser mullvad-browser];
    sessionVariables."BROWSER" = "mullvad-browser";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = ["mullvad-browser.desktop"];
      "x-scheme-handler/http" = ["mullvad-browser.desktop"];
      "x-scheme-handler/https" = ["mullvad-browser.desktop"];
      "x-scheme-handler/chrome" = ["mullvad-browser.desktop"];
      "application/x-extension-htm" = ["mullvad-browser.desktop"];
      "application/x-extension-html" = ["mullvad-browser.desktop"];
      "application/x-extension-shtml" = ["mullvad-browser.desktop"];
      "application/xhtml+xml" = ["mullvad-browser.desktop"];
      "application/x-extension-xhtml" = ["mullvad-browser.desktop"];
      "application/x-extension-xht" = ["mullvad-browser.desktop"];
    };
  };
}
