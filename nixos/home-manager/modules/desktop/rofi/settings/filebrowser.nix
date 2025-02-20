{ config, ... } : {
    programs.rofi.extraConfig = {
        "//filebrowser settings" = config.lib.formats.rasi.mkLiteral ''
            
        filebrowser {
          directories-first: true;
          sorting-method: "name";
        }
        // '';
    };
}
