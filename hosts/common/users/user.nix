{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  username = "user";
in {
  imports = ["${inputs.self}/modules/nixos"];

  users.users.${username} = lib.mkForce {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];

    # INFO: The following line explicitly installs the home-manager CLI tool.
    # Even though it should not be used for system updates in a NixOS settings,
    # it is still useful to read documentation (`man home-configuration.nix`) and
    # the inspection of the current generation.
    packages = [
      inputs.home-manager.packages.${pkgs.system}.default
      pkgs.sops
    ];
    hashedPasswordFile = config.sops.secrets."user/password".path;
  };

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFormat = "yaml";
    secrets."user/password" = {
      sopsFile = ./.secrets.yaml;
      neededForUsers = true;
    };
  };

  home-manager.users.${username} =
    import
    "${inputs.self}/home/${username}/${config.networking.hostName}.nix";
}
