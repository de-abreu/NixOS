{pkgs, ...}: {
  home.packages = with pkgs; [
    grimblast # Screenshot tool
    slurp # region selector for screenshot/screenshare
    swappy # screenshot editor
  ];
}
