{...} : {
    programs.rofi.extraConfig = {
        ssh-client = "ssh";
        ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
        parse-hosts = true;
        parse-known-hosts = true;
    };
}
