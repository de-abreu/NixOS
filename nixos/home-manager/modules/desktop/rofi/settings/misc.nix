{ config, ... } : {
    programs.rofi.extraConfig = {
        sort = false;
	    threads = 0;
	    click-to-exit = true;
	    "// timeout settings" = config.lib.formats.rasi.mkLiteral ''

	    timeout {
	        action: "kb-cancel";
	        delay: 0;
	    }
	    // '';
	};
}
