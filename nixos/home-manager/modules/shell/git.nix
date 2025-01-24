{...}: {
  programs.git = {
    enable = true;
    userName = "Abreu";
    userEmail = "87032834+de-abreu@users.noreply.github.com";
    extraConfig = {
      commit.gpgsign = true;
      tag.gpgsign = true;
      user.signingkey = "0xB655CB8F410F55B6";
    };
  };
}
