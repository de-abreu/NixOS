{
  lib,
  filter,
  userPrefs,
  ...
}: {
  imports = filter ./modules;

  options = {
    "pathToModules" = lib.mkOption {
      type = lib.types.str;      
    };
  };

  config = with userPrefs; {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
      sessionVariables = with defaultApplications; {
        "BROWSER" = browser;
        "EDITOR" = editor;
        "TERM" = term;
      };
    };

    # WARN: Color scheme overrides
    stylix.targets = {
      fish.enable = false; # Set with fish_theme
      neovim.enable = false; # Managed in astroui.lua
      wezterm.enable = false; # Managed in appearance.lua
      hyprlock.enable = false;
    };

    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = with defaultApplications; {
          "application/x-terminal-emulator" = term + ".desktop"; 
          "text/plain" = editor + ".desktop";
        } // (map (mime: {name = mime; value = browser + ".desktop";}) [
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
        |> lib.listToAttrs );
      };
    };
    
    pathToModules = "${flakePath}/nixos/home-manager/modules/";
    
    programs.home-manager.enable = true;
  };
}
