{...} : {
    programs.rofi.extraConfig = {
        window-match-fields = "title,class,role,name,desktop";
	    window-command = "wmctrl -i -R {window}";
	    window-format = "{w} - {c} - {t:0}";
	    window-thumbnail = false;
    }; 
}
