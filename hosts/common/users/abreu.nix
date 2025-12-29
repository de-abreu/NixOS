{
  config,
  inputs,
  pkgs,
  ...
}: let
  username = "abreu";
in {
  users.users.${username} = {
    isNormalUser = true;
    description = "Abreu";
    extraGroups = ["networkmanager" "wheel"];

    # INFO: The following line explicitly installs the home-manager CLI tool.
    # Even though it should not be used for system updates in a NixOS settings,
    # it is still useful to read documentation (`man home-configuration.nix`) and
    # the inspection of the current generation.
    packages = [
      inputs.home-manager.packages.${pkgs.system}.default
      pkgs.sops
    ];
    hashedPasswordFile = config.sops.secrets."root_password".path;
  };

  sops.age.keyFile = "/home/abreu/.config/sops/age/keys.txt";

  home-manager.users.${username} =
    import
    "${inputs.self}/home/${username}/${config.networking.hostName}.nix";
}
