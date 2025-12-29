{
  inputs,
  config,
  osConfig,
  ...
}: {
  imports = [
    ./git.nix
    ../common
    ../features
    inputs.sops-nix.homeManagerModules.sops
  ];

  home = {
    username = "abreu";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.11";
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.self}/secrets/users/abreu.yaml";
    secrets = {
      "api-keys/deepseek" = {};
      "api-keys/tavily" = {};
    };
  };
}
