# INFO: Install developer documentation 

{ pkgs, ... } : {
    environment.systemPackages = with pkgs; [man-pages man-pages-posix];
    documentation = { 
        dev.enable = true; 
        man.generateCaches = true;
    };
}
