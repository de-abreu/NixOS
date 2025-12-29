{ config, ... } : {
    programs.rofi.extraConfig = {
        drun-categories = "";
        drun-match-fields = "name,generic,exec,categories,keywords";
        drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        drun-show-actions = false;
        drun-url-launcher = "xdg-open";
        drun-use-desktop-cache = false;
        "// Drun parsing" = config.lib.formats.rasi.mkLiteral ''
            
        drun {
            parse-user: true; 
            parse-system: true;
        }
        // '';
    };
}
