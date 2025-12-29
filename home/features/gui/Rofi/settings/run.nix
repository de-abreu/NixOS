{...} : {
    programs.rofi.extraConfig = {
        run-command = "{cmd}";
        run-list-command = "";
        run-shell-command = "{terminal} -e {cmd}"; 
    };

}
