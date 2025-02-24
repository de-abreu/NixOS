{userPrefs, ...}: {
  programs.git = with userPrefs.git; {
    enable = true;
    userName = userName;
    userEmail = userEmail;
    extraConfig = {
      commit.gpgsign = true;
      tag.gpgsign = true;
      user.signingkey = signingkey;
    };
  };
}
