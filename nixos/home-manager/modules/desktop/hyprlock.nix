{config, ...}:
with config.lib.stylix; {
  # NOTE: Values are passed here and expanded upon. See reference: https://github.com/danth/stylix/blob/master/modules/hyprlock/hm.nix
  # stylix.targets.hyprlock.enable = false;

  # NOTE: Reference for this setup: https://github.com/fufexan/dotfiles/blob/main/home/programs/wayland/hyprlock.nix
  programs.hyprlock = {
    enable = true;

    #   settings = {
    #     general = {
    #       disable_loading_bar = true;
    #       immediate_render = true;
    #       hide_cursor = false;
    #       no_fade_in = true;
    #     };
    #
    #     background = [
    #       {
    #         monitor = "";
    #         path = "${config.stylix.image}";
    #       }
    #     ];
    #
    #     input-field = with colors; [
    #       {
    #         monitor = "eDP-1";
    #
    #         size = "300, 50";
    #         valign = "bottom";
    #         position = "0%, 10%";
    #
    #         outline_thickness = 1;
    #
    #         font_color = "rgb(${base05})";
    #         outer_color = "rgba(${base03})";
    #         inner_color = "rgba(${base00})";
    #         check_color = "rgba(${base0A})";
    #         fail_color = "rgba(${base08})";
    #
    #         fade_on_empty = false;
    #         placeholder_text = "Enter Password";
    #
    #         dots_spacing = 0.2;
    #         dots_center = true;
    #         dots_fade_time = 100;
    #
    #         shadow_color = "rgba(0, 0, 0, 0.1)";
    #         shadow_size = 7;
    #         shadow_passes = 2;
    #       }
    #     ];
    #
    #     label = with colors; [
    #       {
    #         monitor = "";
    #         text = "$TIME";
    #         font_size = 150;
    #         color = "rgb(${base05})";
    #
    #         position = "0%, 30%";
    #
    #         valign = "center";
    #         halign = "center";
    #
    #         shadow_color = "rgba(0, 0, 0, 0.1)";
    #         shadow_size = 20;
    #         shadow_passes = 2;
    #         shadow_boost = 0.3;
    #       }
    #       {
    #         monitor = "";
    #         text = "cmd[update:3600000] date +'%a %b %d'";
    #         font_size = 20;
    #         color = "rgb(${base05})";
    #
    #         position = "0%, 40%";
    #
    #         valign = "center";
    #         halign = "center";
    #
    #         shadow_color = "rgba(0, 0, 0, 0.1)";
    #         shadow_size = 20;
    #         shadow_passes = 2;
    #         shadow_boost = 0.3;
    #       }
    #     ];
    #   };
  };
}
