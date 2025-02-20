{config, ...} : {
    programs.rofi.extraConfig = with config.stylix.fonts; {
        modi = "drun,run,filebrowser,window";
        case-sensitive = false;
        scroll-method = 0; # 0 - per page; 1 - continuous;
        normalize-match = true; # Ignore accents
        icon-theme = "Flat-Remix-Blue-Dark";
        font = "${monospace.name} ${builtins.toString sizes.terminal}";  
        steal-focus = false;
    };
}
