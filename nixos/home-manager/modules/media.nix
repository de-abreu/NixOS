{pkgs, ...}: {
  home.packages = with pkgs; [celluloid kdePackages.kdenlive];
}
