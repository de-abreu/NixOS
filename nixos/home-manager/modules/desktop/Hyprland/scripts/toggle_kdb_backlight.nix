{ pkgs, ... } : with pkgs; let
    bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    device = "dell::kbd_backlight";
    toggle_kdb_backlight = pkgs.writeShellScriptBin "toggle_kdb_backlight"
    ''
    if [[ $(${bcrl} -d ${device}) -eq 0 ]]; then
        ${bctl} -rd ${device}
    else
        ${bctl} -sd ${device} set 0
    fi
    '';
in {
    home.packages = [toggle_kdb_backlight];
}
