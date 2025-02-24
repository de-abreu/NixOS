{config, pkgs, ...}: let
    launcher = pkgs.writeShellScriptBin "launcher" ''
        theme="$XDG_CONFIG_HOME/rofi/launcher.rasi"
        if [ $# -gt 0 ]; then
            rofi -show $1 -theme $theme
        else
            rofi -show drun -theme $theme
        fi 
    '';
in {
    home.packages = [launcher];
    xdg.configFile."rofi/launcher.rasi".source = with config;
        lib.file.mkOutOfStoreSymlink
        "${pathToModules}/desktop/rofi/launcher/launcher.rasi"; 
}
