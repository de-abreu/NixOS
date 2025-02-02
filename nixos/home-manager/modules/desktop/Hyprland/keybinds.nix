# TODO: Enable notifications, brightness controls, screenshots and screencaptures
{
  config,
  lib,
  ...
}:
with lib;
with config.lib.stylix.colors; let
  moveWindows =
    (concatStringsSep "\n" (map (n:
      replaceStrings ["N"] [(toString n)] ''
        bind =, N, movetoworkspace, N
        bind =, N, exec, hyprctl keyword general:col.active_border "rgb(${base08})"
        bind =, N, submap, hyprmode
      '') (range 1 9)))
    + ''

      bind =, 0, movetoworkspace, 10
      bind =, 0, exec, hyprctl keyword general:col.active_border "rgb(${base08})"
      bind =, 0, submap, hyprmode
    '';
in {
  wayland.windowManager.hyprland.extraConfig =
    ''

      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█


      $ccedilla = code:47 # Map c cedilla for ABNT2 keyboards

      # Default mode keybindings
      submap = reset

      ## Media controls
      binddl = , XF86AudioMute, Toggle audio mute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      binddl = , XF86AudioNext, Next media, exec, playerctl next
      binddl = , XF86AudioPlay, Play media, exec, playerctl play-pause
      binddl = , XF86AudioPrev, Previous media, exec, playerctl previous
      bindedl = , XF86AudioLowerVolume, Lower volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindedl = , XF86AudioRaiseVolume, Raise volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+

      # Hyprmode keybindings
      bind = SUPER, Super_L, exec, hyprctl keyword general:col.active_border "rgb(${base08})"
      bindd = SUPER, Super_L, Enter Hyprmode, submap, hyprmode
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
      bind = , z, submap, reset
      bindd = , q, Lock Screen, exec, swaylock
      bind = , q, submap, reset

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
      bind = SUPER, Super_L, exec, hyprctl keyword general:col.active_border "rgb(${base0D})"
      bindd = SUPER, Super_L, Exit Hyprmode, submap, reset
      bind = ,catchall, exec,

      submap =  MoveWindowToWorkspace
    ''
    + moveWindows
    + ''

      ## Move focused window to a relative workspace
      binded = , j , Move window to previous workspace, movetoworkspace, -1
      binded = , $ccedilla , Move window to next workspace, movetoworkspace, +1

      bindd = , s, Silently Move focused window to a workspace, submap, SilentlyMoveWindowToWorkspace
      bindd = , catchall, Cancel and return to default mode, exec, hyprctl keyword general:col.active_border "rgb(${base0D})"; hyprctl dispatch submap reset

      ### Move focused window to another workspace, silently
      submap = SilentlyMoveWindowToWorkspace
    ''
    + (replaceStrings [" movetoworkspace"] [" movetoworkspacesilent"] moveWindows)
    + ''

      bind = , catchall, exec, hyprctl keyword general:col.active_border "rgb(${base0D})"; hyprctl dispatch submap reset
      submap = reset
    '';
}
