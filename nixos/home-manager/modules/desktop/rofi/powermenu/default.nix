{config, pkgs, ...} : let 
    rasi = "rofi/powermenu.rasi";
    powermenu = pkgs.writeShellScriptBin "powermenu" ''
        uptime="$(uptime | sed 's/.* \([0-9]\{1,2\}:[0-9]\{1,2\}\),.*/\1/')"
        host=$(hostname)
        theme="$XDG_CONFIG_HOME/${rasi}"

        # Options
        shutdown=' Shutdown'
        reboot=' Reboot'
        lock=' Lock'
        suspend=' Suspend'
        logout=' Logout'
        yes=' Yes'
        no=' No'

        # Rofi CMD
        rofi_cmd() {
	        rofi -dmenu \
		        -p "$host" \
		        -mesg "Uptime: $uptime" \
		        -theme $theme
        }

        # Confirmation CMD
        confirm_cmd() {
	        rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
		        -theme-str 'listview {columns: 2; lines: 1;}' \
		        -theme-str 'element-text {horizontal-align: 0.5;}' \
		        -theme-str 'textbox {horizontal-align: 0.5;}' \
		        -dmenu \
		        -p 'Confirmation' \
		        -mesg 'Are you Sure?' \
				-theme $theme
        }

        # Ask for confirmation
        confirm_exit() {
	        echo -e "$yes\n$no" | confirm_cmd
        }

        # Pass variables to rofi dmenu
        run_rofi() {
	        echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
        }

        # Execute Command
        run_cmd() {
            if [[ $1 == '--lock' || $1 == '--suspend' ]]; then
			    ${pkgs.playerctl}/bin/playerctl pause
		        loginctl lock-session
			    if [[ $1 == '--suspend' ]]; then
				    systemctl suspend
			    fi
		    elif [[ "$(confirm_exit)" == "$yes" ]]; then
				if [[ $1 == '--shutdown' ]]; then
			        systemctl poweroff
		        elif [[ $1 == '--reboot' ]]; then
			        systemctl reboot
		        else
		            loginctl terminate-session $XDG_SESSION_ID
		        fi
		    else
		        exit 0
	        fi
	    }

        # Actions
        case "$(run_rofi)" in
        $shutdown)
	        run_cmd --shutdown
	        ;;
        $reboot)
	        run_cmd --reboot
	        ;;
        $lock)
	        run_cmd --lock
	        ;;
        $suspend)
	        run_cmd --suspend
	        ;;
        $logout)
	        run_cmd --logout
	        ;;
        esac        
    '';
in {
    home.packages = [powermenu];
    xdg.configFile."${rasi}".source = config.lib.file.mkOutOfStoreSymlink
        "${config.pathToModules}/desktop/${rasi}";
}
