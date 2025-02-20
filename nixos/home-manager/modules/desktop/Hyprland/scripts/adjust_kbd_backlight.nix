{ pkgs, ... } : let
    bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    device = "dell::kbd_backlight";
    adjust_kbd_backlight = pkgs.writers.writeLuaBin "adjust_kbd_backlight" {} 
        # Lua
        ''
        local bctl = "${bctl}"
        bctl = bctl .. " -d ${device}"
        local handle = io.popen(bctl .." get")
        local next = (tonumber(handle:read("*a")) + 1) % 3
        handle:close()

        os.execute(bctl .. " set " .. next)
        '';
in {
    home.packages = [adjust_kbd_backlight];
}
