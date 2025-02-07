# TODO: Enable notifications, brightness controls, screenshots and screencaptures
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with config.lib.stylix.colors; let
  bind = set: "bind${elemAt set 2} = ${elemAt set 0}, ${elemAt set 1}\n";
  submap = {
    name ? "reset",
    binds,
  }: ["submap = ${name}\n"] ++ (map (set: bind set) binds) ++ ["submap = reset\n"] |> ( a: concatStrings a );
  changeSubmap = name: indicator: "exec, hyprctl keyword general:col.active_border \"rgb(${indicator})\"; hyprctl dispatch submap ${name}";
  toDefault = changeSubmap "reset" base0D;
  toHyprmode = changeSubmap "hyprmode" base08;
  toMWTW = changeSubmap "MoveWindowToWorkspace" base0B;
  moveWindows = range 1 9
    |> map (elem: toString elem)
    |> fold (n: acc:  [[", ${n}" "movetoworkspace, ${n}" ""] [", ${n}" toHyprmode ""]] ++ acc) [
    [", 0" "movetoworkspace, 10" ""]
    [", 0" toHyprmode ""]
    [", j" "Move window to previous workspace, movetoworkspace, -1" "ed"]
    [", $ccedilla" "Move window to next workspace, movetoworkspace, +1" "ed"]
  ];
  shared = [
        # Media controls
        [", XF86AudioMute" "Toggle audio mute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" "dlt"]
        [", XF86AudioNext" "Next media, exec, playerctl next" "dlt"]
        [", XF86AudioPlay" "Toggle play media, exec, playerctl play-pause" "dlt"]
        [", XF86AudioPrev" "Previous media, exec, playerctl previous" "dlt"]
        [", XF86AudioLowerVolume" "Lower volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" "edlt"]
        [", XF86AudioRaiseVolume" "Raise volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" "edlt"]

        # Lid open/close
        [", switch:on:[Lid Switch]" "exec, ${toDefault}; loginctl lock-session" "lt"]
        [", switch:on:[Lid Switch]" "exec, hyprctl keyword monitor \"eDP-1, disable\"" "lt"]
        [", switch:off:[Lid Switch]" "exec, hyprctl keyword monitor \"eDP-1, 2560x1600, 0x0, 1\"" "lt"]

        # Power button
        [", XF86PowerOff" "exec, ${toDefault}; systemctl suspend" "lt"]    
  ];
in {
  home.packages = [pkgs.playerctl]; # Command-line utility to control media players
  wayland.windowManager.hyprland.extraConfig =
    ''

      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

      $ccedilla = code:47 # Map c cedilla for ABNT2 keyboards

    ''
    # Default mode keybindings
    + (submap { binds = shared ++ [ ["SUPER, Super_L" "Enter Hyprmode, ${toHyprmode}" "d"] ]; })
    # Hyprmode keybindings
    + (submap {
      name = "hyprmode";
      binds = shared
        ++ [
          # Application shortcuts
          [", t" "Open Terminal, exec, $term" "d"]
          [", f" "Open File Manager, exec, $file" "d"]
          [", ENTER" "Open Editor, exec, $editor" "d"]
          [", b" "Open Clearnet Broswer, exec, $browser" "d"]

          # Window/ Session controls
          [", c" "Close Window, killactive" "d"]
          [", y" "Toogle floating window, togglefloating" "d"]
          [", z" "Toggle maximize window, fullscreen" "d"]
          [", q" "Lock Screen, exec, ${toDefault}; loginctl lock-session" "d"]

          [", j" "Focus left window, movefocus, l" "d"]
          [", k" "Focus window below, movefocus, d" "d"]
          [", l" "Focus window above, movefocus, u" "d"]
          [", $ccedilla" "Focus right window, movefocus, r" "d"]

          ["ALT, j" "Resize left, resizeactive, -30 0" "d"]
          ["ALT, k" "Resize down, resizeactive, 0 30" "d"]
          ["ALT, l" "Resize up, resizeactive, 0 -30" "d"]
          ["ALT, $ccedilla" "Resize right, resizeactive, 30 0" "d"]

          ["SHIFT, j" "Swap with left window, swapwindow, l" "d"]
          ["SHIFT, k" "Swap with window below, swapwindow, k" "d"]
          ["SHIFT, l" "Swap with window above, swapwindow, u" "d"]
          ["SHIFT, $ccedilla" "Swap with right window, swapwindow, r" "d"]
        ]
        # Switch workspaces
        ++ (range 1 9 |> map (elem: toString elem) |> fold (elem: acc: [[", ${elem}" "workspace, ${elem}" ""]] ++ acc) [
          ["CTRL, j" "Go one workspace left, workspace, -1" "d"]
          ["CTRL, $ccedilla" "Go one workspace right, workspace, +1" "d"]
          [", 0" "workspace, 10" ""]
        ])
        # Exit Hyprmode
        ++ [
          [", m" "Move focused window to a workspace, ${toMWTW}" "d"]
          ["SUPER, Super_L" "Exit Hyprmode, ${toDefault}" "d"]
        ];
    })
    # Move window keybindings
    + (submap {
      name = "MoveWindowToWorkspace";
      binds = shared
        ++ moveWindows
        ++ [
          [", s" "Silently Move focused window to a workspace, submap, SilentlyMoveWindowToWorkspace" "d"]
          [", catchall" "Cancel and return to default mode, ${toDefault}" "d"]
        ];
    })
    # Move window silently keybindings
    + (submap {
      name = "SilentlyMoveWindowToWorkspace";
      binds = shared ++ (map (bind: [
        (elemAt bind 0)
        (elemAt bind 1 |> replaceStrings ["movetoworkspace" "Move window"] ["movetoworkspacesilent" "Move window silently"])
        (elemAt bind 2)]) moveWindows)
      ++ [ [ ", catchall" "Cancel and return to default mode, ${toDefault}" "d" ] ];
    });
}
