# TODO: Enable notifications, brightness controls, screenshots and screencaptures
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with config.lib.stylix.colors; let
  enterHyprmode = "exec, hyprctl keyword general:col.active_border \"rgb(${base08})\"; hyprctl dispatch submap hyprmode";
  resetMode = "exec, hyprctl keyword general:col.active_border \"rgb(${base0D})\"; hyprctl dispatch submap reset";
  moveWindows =
    (concatStringsSep "\n" (map (n:
      replaceStrings ["N"] [(toString n)] ''
        bind =, N, movetoworkspace, N
        bind =, N, exec, ${enterHyprmode}
      '') (range 1 9)))
    + ''

      bind =, 0, movetoworkspace, 10
      bind =, 0, exec, ${enterHyprmode}

      ## Move focused window to a relative workspace
      binded = , j , Move window to previous workspace, movetoworkspace, -1
      binded = , $ccedilla , Move window to next workspace, movetoworkspace, +1

    '';
in {
  home.packages = [pkgs.playerctl]; # Command-line utility to control media players
  wayland.windowManager.hyprland.extraConfig =
    ''

      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

      $ccedilla = code:47 # Map c cedilla for ABNT2 keyboards
      # Default mode keybindings
      submap = reset

      ## Media controls
      binddlt = , XF86AudioMute, Toggle audio mute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      binddlt = , XF86AudioNext, Next media, exec, playerctl next
      binddlt = , XF86AudioPlay, Play media, exec, playerctl play-pause
      binddlt = , XF86AudioPrev, Previous media, exec, playerctl previous
      bindedlt = , XF86AudioLowerVolume, Lower volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindedlt = , XF86AudioRaiseVolume, Raise volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+

      ## Lid open/close event
      bindlt = , switch:on:[Lid Switch], exec, ${resetMode}; loginctl lock-session
      # trigger when the switch is turning on
      bindlt = , switch:on:[Lid Switch], exec, hyprctl keyword monitor "eDP-1, disable"
      # trigger when the switch is turning off
      bindlt = , switch:off:[Lid Switch], exec, hyprctl keyword monitor "eDP-1, 2560x1600, 0x0, 1"

      ## Power button
      bindt = , XF86PowerOff, exec, ${resetMode}; systemctl suspend

      # Hyprmode keybindings
      bindd = SUPER, Super_L, Enter Hyprmode, ${enterHyprmode}
      submap = hyprmode

      ## Application shortcuts
      bindd = , t, Open Terminal, exec, $term
      bindd = , f, Open File Manager, exec, $file
      bindd = , ENTER, Open Editor, exec, $editor
      bindd = , b, Open Clearnet Broswer, exec, $browser

      ## Window/Session controls
      bindd = , c, Close Window, killactive
      bindd = , y, Toogle floating window, togglefloating
      bindd = , z, Toggle maximize window, fullscreen
      bindd = , q, Lock Screen, exec, ${resetMode}; loginctl lock-session

      binded = , j, Focus left window, movefocus, l
      binded = , k, Focus window below, movefocus, d
      binded = , l, Focus window above, movefocus, u
      binded = , $ccedilla, Focus right window, movefocus, r

      binded = ALT, j, Resize left, resizeactive, -30 0
      binded = ALT, k, Resize down, resizeactive, 0 30
      binded = ALT, l, Resize up, resizeactive, 0 -30
      binded = ALT, $ccedilla, Resize right, resizeactive, 30 0

      binded = SHIFT, j, Swap with left window, swapwindow, l
      binded = SHIFT, k, Swap with window below, swapwindow, k
      binded = SHIFT, l, Swap with window above, swapwindow, u
      binded = SHIFT, $ccedilla, Swap with right window, swapwindow, r

      ## Switch workspaces
    ''
    + (concatStringsSep "\n" (map (n: replaceStrings ["N"] [(toString n)] "bind = , N, workspace, N") (range 1 9)))
    + ''

      bind = , 0, workspace, 10

      bindd = CTRL, j, Go one workspace left, workspace, -1
      bindd = CTRL, $ccedilla, Go one workspace right, workspace, +1

      ## Exit Hyprmode
      bind = , m, exec, hyprctl keyword general:col.active_border "rgb(${base0B})"
      bindd = , m, Move focused window to a workspace, submap, MoveWindowToWorkspace
      bindd = SUPER, Super_L, Exit Hyprmode, ${resetMode}
      bind = ,catchall, exec,

      submap =  MoveWindowToWorkspace
    ''
    + moveWindows
    + ''

      bindd = , s, Silently Move focused window to a workspace, submap, SilentlyMoveWindowToWorkspace
      bindd = , catchall, Cancel and return to default mode, exec, ${resetMode}

      ### Move focused window to another workspace, silently
      submap = SilentlyMoveWindowToWorkspace
    ''
    + (replaceStrings [" movetoworkspace"] [" movetoworkspacesilent"] moveWindows)
    + ''

      bindd = , catchall, Cancel and return to default mode, exec, ${resetMode}
      submap = reset
    '';
}
