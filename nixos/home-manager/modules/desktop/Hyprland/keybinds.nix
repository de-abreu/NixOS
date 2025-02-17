# TODO: Enable notifications, brightness controls, screenshots and screencaptures
{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {  
    settings = with config.lib.stylix.colors; let
      changeSubmap = name: indicator:
        "hyprctl keyword general:col.active_border \"rgb(${indicator})\"; hyprctl dispatch submap ${name}";
      in {
      "$ccedilla" = "code:47"; # Map c cedilla for ABNT2 keyboards
      "$keyboard" = "dell::kbd_backlight";
      "$mute" = "set-mute @DEFAULT_AUDIO_SINK@";
      "$screenlock" = "playerctl pause; loginctl lock-session";
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
      }: ["submap = ${name}\n"] ++ (map (set: bind set) binds) ++ ["submap = reset\n"]
        |> concatStrings;
      moveWindows = range 1 9
        |> map (elem: toString elem)
        |> fold (n: acc:  [
          ["" "${n}" "movetoworkspace, ${n}" ""]
          ["" "${n}" "exec, $toHyprmode" ""]
        ] ++ acc) [
          ["" "0" "movetoworkspace, 10" ""]
          ["" "0" "exec, $toHyprmode" ""]
          ["" "j" "Move window to previous workspace, movetoworkspace, -1" "ed"]
          ["" "$ccedilla" "Move window to next workspace, movetoworkspace, +1" "ed"]
        ];
      application_shortcuts = [
        [ "t" "Open Terminal, exec, $term" "d"]
        [ "f" "Open File Manager, exec, $file" "d"]
        [ "b" "Open Clearnet Broswer, exec, $browser" "d"]
      ];
      window_session_shortcuts = [
        [ "q" "Close Window, killactive" "d"]
        [ "y" "Toogle floating window, togglefloating" "d"]
        [ "z" "Toggle maximize window, fullscreen" "d"]
        [ "c" "Lock session, exec, $screenlock; $toDefault" "d"]

        [ "j" "Focus left window, movefocus, l" "d"]
        [ "k" "Focus window below, movefocus, d" "d"]
        [ "l" "Focus window above, movefocus, u" "d"]
        [ "$ccedilla" "Focus right window, movefocus, r" "d"]
        [ "[" "Focus previous window, cyclenext, prev" "d"]
        [ "]" "Focus previous window, cyclenext" "d"]
      ];
      shared = [
        # Media controls
        ["" "XF86AudioMute" "Toggle audio mute, exec, $mute toggle" "dlt"]
        ["" "XF86AudioNext" "Next media, exec, playerctl next" "dlt"]
        ["" "XF86AudioPlay" "Toggle play media, exec, playerctl play-pause" "dlt"]
        ["" "XF86AudioPrev" "Previous media, exec, playerctl previous" "dlt"]
        ["" "XF86AudioLowerVolume" "Lower volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" "edlt"]
        ["" "XF86AudioRaiseVolume" "Raise volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" "edlt"]
        # Brightness controls
        ["" "XF86MonBrightnessUp" "Increase monitor brightness, exec, brightnessctl set +10%" "edtl"]
        ["" "XF86MonBrightnessDown" "Decrease monitor brightness, exec, brightnessctl set 10%-" "edtl"]
        ["" "XF86KbdLightOnOff" "Toggle keyboard backlight, exec, toggle_kbd_backlight" "dlt"]
        
        # Lid open/close
        ["" "switch:on:[Lid Switch]" "exec, hyprctl keyword monitor \"eDP-1, disable\"; $screenlock; $toDefault" "lt"]
        ["" "switch:off:[Lid Switch]" "exec, hyprctl keyword monitor \"eDP-1, 2560x1600, 0x0, 1\"" "lt"]
        # Power button
        ["" "XF86PowerOff" "exec, $toDefault; $screenlock; systemctl suspend" "lt"]    
      ];
    in
      # Default mode keybindings
      (submap {
        binds = application_shortcuts ++ window_session_shortcuts ++ [ ["Super_L" "Enter Hyprmode, exec,  $toHyprmode" "d"] ]
          |> map (bind: ["SUPER"] ++ bind)
          |> (binds : binds ++ shared);
      })
      # Hyprmode keybindings
      + (submap {
        name = "hyprmode";
        binds = application_shortcuts ++ window_session_shortcuts ++ [ ["End" "Power off, exec, poweroff" "d"] ]
          |> map (bind: [""] ++ bind)
          |> (binds: binds ++ [
            ["ALT" "j" "Resize left, resizeactive, -30 0" "d"]
            ["ALT" "k" "Resize down, resizeactive, 0 30" "d"]
            ["ALT" "l" "Resize up, resizeactive, 0 -30" "d"]
            ["ALT" "$ccedilla" "Resize right, resizeactive, 30 0" "d"]

            ["SHIFT" "j" "Swap with left window, swapwindow, l" "d"]
            ["SHIFT" "k" "Swap with window below, swapwindow, k" "d"]
            ["SHIFT" "l" "Swap with window above, swapwindow, u" "d"]
            ["SHIFT" "$ccedilla" "Swap with right window, swapwindow, r" "d"]
          ]
          # Switch workspaces
          ++ (range 1 9 |> map (elem: toString elem) |> fold (elem: acc: [["" "${elem}" "workspace, ${elem}" ""]] ++ acc) [
            ["CTRL" "j" "Go one workspace left, workspace, -1" "d"]
            ["CTRL" "$ccedilla" "Go one workspace right, workspace, +1" "d"]
            ["" "0" "workspace, 10" ""]
          ])
          # Exit Hyprmode
          ++ [
            ["" "m" "Move focused window to a workspace, exec, $toMWTW" "d"]
            ["SUPER" "Super_L" "Exit Hyprmode, exec, $toDefault" "d"]
            ["" "catchall" "exec" ""]
          ]);
        })
      # Move window keybindings
      + (submap {
        name = "MoveWindowToWorkspace";
        binds = shared
          ++ moveWindows
          ++ [
            ["" "s" "Silently Move focused window to a workspace, submap, SilentlyMoveWindowToWorkspace" "d"]
            ["" "catchall" "Cancel and return to default mode, exec, $toDefault" "d"]
          ];
      })
      # Move window silently keybindings
      + (submap {
        name = "SilentlyMoveWindowToWorkspace";
        binds = map (bind: [
          (elemAt bind 0)
          (elemAt bind 1)
          (elemAt bind 2 |> replaceStrings ["movetoworkspace" "Move window"] ["movetoworkspacesilent" "Move window silently"])
          (elemAt bind 3)
        ]) moveWindows
        |> (binds: binds ++ shared ++ [[ "" "catchall" "Cancel and return to default mode, exec, $toDefault" "d" ]]);
      });
  };
}
