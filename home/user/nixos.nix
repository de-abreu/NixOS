{
  inputs,
  config,
  ...
}: let
  username = baseNameOf ./.;
in {
  imports = [
    ../common
    "${inputs.self}/modules/home-manager"
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  programs.git.settings = {
    user = {
      name = "Abreu";
      mail = "87032834+de-abreu@users.noreply.github.com";
    };
    commit.gpgsign = true;
    tag.gpgsign = true;
    user.signingkey = "0xB655CB8F410F55B6";
    push.default = "current";
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./.secrets.yaml;
    secrets = {
      "api-keys/deepseek" = {};
      "api-keys/tavily" = {};
    };
  };
}
