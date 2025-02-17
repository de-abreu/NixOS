{pkgs} : let
    bctl = pkgs.brightnessctl;
    device = "dell::kbd_backlight";
in
pkgs.writeShellScriptBin "toggle_kbd_backlight" ''
    if [[ $(${bctl} -d ${device} get) -eq 0 ]]; then
        ${bctl} -rd ${device}
    else
        ${bctl} -sd ${device} set 0
    fi
''
