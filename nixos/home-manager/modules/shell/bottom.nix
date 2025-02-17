# INFO: A process monitor

{pkgs, ...} : {
    home.packages = [pkgs.bottom];
    programs.fish.shellAbbrs.bottom = "btm";
}
