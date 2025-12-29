{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./Hypr
    ./Rofi
    ./browsers.nix
    ./feh.nix
    ./file-roller.nix
    ./media.nix
    ./study.nix
    ./wezterm
    ./wlogout.nix
  ];

  options = with pkgs;
  with lib; {
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
