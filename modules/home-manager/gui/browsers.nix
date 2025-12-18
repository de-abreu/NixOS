# INFO: Installs GUI based browsers, with Librewolf as the user's default
{
  lib,
  pkgs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    languagePacks = ["en-US" "pt-BR"];
    settings = {
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.translations.neverTranslateLanguages" = "pt";
      "privacy.resistFingerprinting.letterboxing" = true;
    };
  };
  stylix.targets.librewolf.profileNames = ["default"];
  home = {
    packages = [pkgs.tor-browser];
    sessionVariables.BROWSER = "librewolf";
  };
  wayland.windowManager.hyprland.settings."$browser" = "librewolf";
  xdg.mimeApps.defaultApplications = let
    application = "librewolf.desktop";
  in
    map (mime: {
      name = mime;
      value = application;
    }) [
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
