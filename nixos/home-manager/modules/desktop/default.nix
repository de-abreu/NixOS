{ lib, pkgs, ...}: {
    imports = [
        ./Hypr
        ./rofi
        ./chiphist
        ./dunst
        ./gtk
        ./hyprpaper
        ./screenlock
        ./screenshot
        ./swww
        ./waybar
        ./wlogout
    ];

    options = with pkgs; with lib; {
        actl = mkOption {
            type = types.str;
            description = "Path to program used for audio control";
            default = "${wireplumber}/bin/wpctl";
        };
        bctl = mkOption {
            type = types.str;
            description = "Path to program used for brightness control";
            default = "${brightnessctl}/bin/brightnessctl";
        };
        pctl = mkOption {
            type = types.str;
            description = "Path to program used for media control";
            default = "${playerctl}/bin/playerctl";
        };
    };
}
