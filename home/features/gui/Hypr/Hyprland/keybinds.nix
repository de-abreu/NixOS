{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = with config.lib.stylix.colors; let
      changeSubmap = name: indicator: "hyprctl keyword general:col.active_border \"rgb(${indicator})\"; hyprctl dispatch submap ${name}";
    in {
      "$apostrophe" = "code:49";
      "$ccedilla" = "code:47";
      "$printScreen" = "code:107";
      "$mute" = "${config.actl} set-mute @DEFAULT_AUDIO_SINK@";
      "$screenlock" = "${config.pctl} pause; loginctl lock-session";
      "$toDefault" = changeSubmap "reset" base0D;
      "$toHyprmode" = changeSubmap "hyprmode" base08;
      "$toMWTW" = changeSubmap "MoveWindowToWorkspace" base0B;
    };

    # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
    # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

    extraConfig = with lib; let
      bind = set: "bind${elemAt set 3} = ${elemAt set 0}, ${elemAt set 1}, ${elemAt set 2}\n";
      submap = {
        name ? "reset",
        binds,
      }:
        ["submap = ${name}\n"]
        ++ (map (set: bind set) binds) ++ ["submap = reset\n"]
        |> concatStrings;
      moveWindows =
        range 1 9
        |> map (elem: toString elem)
        |> fold (n: acc:
          [
            ["" "${n}" "movetoworkspace, ${n}" ""]
            ["" "${n}" "exec, $toHyprmode" ""]
          ]
          ++ acc) [
          ["" "0" "movetoworkspace, 10" ""]
          ["" "0" "exec, $toHyprmode" ""]
          ["" "j" "Move window to previous workspace, movetoworkspace, -1" "ed"]
          ["" "$ccedilla" "Move window to next workspace, movetoworkspace, +1" "ed"]
        ];
      application_shortcuts = [
        ["b" "Open Clearnet Broswer, exec, $browser; $toDefault" "d"]
        ["f" "Open File Manager, exec, $FILEBROWSER; $toDefault" "d"]
        ["w" "Open Terminal, exec, $terminal; $toDefault" "d"]
        ["space" "Applications, exec, launcher & disown; $toDefault" "d"]
        ["Tab" "Windows, exec, launcher window & disown; $toDefault" "d"]
        ["$apostrophe" "Lock session, exec, powermenu & disown; $toDefault" "d"]
      ];
      window_session_shortcuts = [
        ["g" "Toggle grouping, togglegroup" "d"]
        ["q" "Close Window, killactive" "d"]
        ["y" "Toogle floating window, togglefloating" "d"]
        ["z" "Toggle maximize window, fullscreen" "d"]
        ["j" "Focus left window, movefocus, l" "d"]
        ["k" "Focus window below, movefocus, d" "d"]
        ["l" "Focus window above, movefocus, u" "d"]
        ["$ccedilla" "Focus right window, movefocus, r" "d"]
        ["bracketleft" "Focus previous window, cyclenext, prev" "d"]
        ["bracketright" "Focus previous window, cyclenext" "d"]
      ];
      workspace_shortcuts =
        range 1 9
        |> map (elem: toString elem)
        |> fold (elem: acc: [["${elem}" "workspace, ${elem}" ""]] ++ acc) [
          ["0" "workspace, 10" ""]
        ];

      shared = let
        device = "dell::kbd_backlight";
        adjust_kbd_backlight =
          pkgs.writers.writeLuaBin "adjust_kbd_backlight" {}
          # Lua
          ''
            local bctl = "${config.bctl}"
            bctl = bctl .. " -d ${device}"
            local handle = io.popen(bctl .." get")
            local next = (tonumber(handle:read("*a")) + 1) % 3
            handle:close()

            os.execute(bctl .. " set " .. next)
          '';
        hyprpicker = "${pkgs.hyprpicker}/bin/hyprpicker";
      in [
        # Media controls
        ["" "XF86AudioMute" "Toggle audio mute, exec, $mute toggle" "dlt"]
        ["" "XF86AudioNext" "Next media, exec, ${config.pctl} next" "dlt"]
        ["" "XF86AudioPlay" "Toggle play media, exec, ${config.pctl} play-pause" "dlt"]
        ["" "XF86AudioPrev" "Previous media, exec, ${config.pctl} previous" "dlt"]
        ["" "XF86AudioLowerVolume" "Lower volume, exec, $mute 0; ${config.actl} set-volume @DEFAULT_AUDIO_SINK@ 5%-" "edlt"]
        ["" "XF86AudioRaiseVolume" "Raise volume, exec, $mute 0; ${config.actl} set-volume @DEFAULT_AUDIO_SINK@ 5%+" "edlt"]

        # Color picker
        ["" "F9" "Color picker, exec, sleep 0.5 && ${hyprpicker} -a" "dt"]

        # Brightness controls
        ["" "XF86KbdLightOnOff" "Toggle keyboard backlight, exec, ${adjust_kbd_backlight}" "dlt"]
        ["" "XF86MonBrightnessUp" "Increase monitor brightness, exec, ${config.bctl} set +10%" "edtl"]
        ["" "XF86MonBrightnessDown" "Decrease monitor brightness, exec, ${config.bctl} set 10%-" "edtl"]

        # Screenshot
        ["" "$printScreen" "Screenshot, exec, screenshot" "dt"]

        # Lid open/close
        ["" "switch:on:[Lid Switch]" "exec, hyprctl keyword monitor \"eDP-1, disable\"; $screenlock; $toDefault" "lt"]
        ["" "switch:off:[Lid Switch]" "exec, hyprctl keyword monitor \"eDP-1, 2560x1600, 0x0, 1\"" "lt"]

        # Power button
        ["" "XF86PowerOff" "exec, $toDefault; $screenlock; systemctl suspend" "lt"]
      ];
    in
      # Default mode keybindings
      (submap {
        binds =
          application_shortcuts
          ++ window_session_shortcuts
          ++ workspace_shortcuts
          ++ [
            ["mouse:272" "Move Window, movewindow" "md"]
            ["Super_L" "Enter Hyprmode, exec, $toHyprmode" "d"]
          ]
          |> map (bind: ["SUPER"] ++ bind)
          |> (binds: binds ++ shared);
      })
      # Hyprmode keybindings
      + (submap {
        name = "hyprmode";
        binds =
          application_shortcuts
          ++ window_session_shortcuts
          ++ workspace_shortcuts
          |> map (bind: [""] ++ bind)
          |> (binds:
            binds
            ++ [
              ["ALT" "j" "Resize left, resizeactive, -30 0" "de"]
              ["ALT" "k" "Resize down, resizeactive, 0 30" "de"]
              ["ALT" "l" "Resize up, resizeactive, 0 -30" "de"]
              ["ALT" "$ccedilla" "Resize right, resizeactive, 30 0" "de"]

              ["SHIFT" "j" "Swap with left window, swapwindow, l" "de"]
              ["SHIFT" "k" "Swap with window below, swapwindow, d" "de"]
              ["SHIFT" "l" "Swap with window above, swapwindow, u" "de"]
              ["SHIFT" "$ccedilla" "Swap with right window, swapwindow, r" "de"]
              ["SHIFT" "bracketleft" "Focus previous window, swapnext, prev" "de"]
              ["SHIFT" "bracketright" "Focus previous window, swapnext" "de"]

              ["CTRL" "j" "Go one workspace left, workspace, -1" "de"]
              ["CTRL" "$ccedilla" "Go one workspace right, workspace, +1" "de"]
            ]
            # Exit Hyprmode
            ++ [
              ["" "m" "Move focused window to a workspace, exec, $toMWTW" "d"]
              ["SHIFT" "m" "Silently Move focused window to a workspace, submap, SilentlyMoveWindowToWorkspace" "d"]
              ["SUPER" "mouse:272" "Move Window, movewindow" "md"]
              ["SUPER" "Super_L" "Exit Hyprmode, exec, $toDefault" "d"]
              ["" "catchall" "exec" ""]
            ]
            ++ shared);
      })
      # Move window keybindings
      + (submap {
        name = "MoveWindowToWorkspace";
        binds =
          shared
          ++ moveWindows
          ++ [
            ["" "s" "Silently Move focused window to a workspace, submap, SilentlyMoveWindowToWorkspace" "d"]
            ["" "catchall" "Cancel and return to default mode, exec, $toDefault" "d"]
          ];
      })
      # Move window silently keybindings
      + (submap {
        name = "SilentlyMoveWindowToWorkspace";
        binds =
          map (bind: [
            (elemAt bind 0)
            (elemAt bind 1)
            (elemAt bind 2 |> replaceStrings ["movetoworkspace" "Move window"] ["movetoworkspacesilent" "Move window silently"])
            (elemAt bind 3)
          ])
          moveWindows
          |> (binds: binds ++ shared ++ [["" "catchall" "Cancel and return to default mode, exec, $toDefault" "d"]]);
      });
  };
}
