# INFO: Installing study related programs.
{pkgs, ...}: {
  home.packages = with pkgs; [anki libreoffice-still zotero];

  programs = {
    # The zotero extension for Chromium
    chromium.extensions = [{id = "ekhagklcjbdpajgpjgmbionohlpdbjgc";}];
    zathura = {
      enable = true;
      mappings = {
        K = "navigate next";
        L = "navigate previous";
        j = "scroll left";
        k = "scroll down";
        l = "scroll up";
        "ç" = "scroll right";
      };
      options.selection-clipboard = "clipboard"; # Enables copying text to clipboard
    };
  };
  xdg.mimeApps.defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
  wayland.windowManager.hyprland.settings.windowrule = ["opacity 0.8, class:org.pwmt.zathura"];
}
