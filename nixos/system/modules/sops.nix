{userPrefs, ...}: {
  sops = with userPrefs; {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    secrets = let
      read_permissions = {
        owner = username;
        mode = "0440";
      };
    in
      map (key: {
        name = "api_keys/${key}";
        value = read_permissions;
      }) ["deepseek" "tavily"]
      |> builtins.listToAttrs;
  };
}
