{lib, ...}:
with lib; {
  i18n = {
    # 1. Set the language for the UI (System messages, Menus, Help)
    defaultLocale = mkForce "en_US.UTF-8";

    # 2. Override specific "Regional" settings to Brazil
    extraLocaleSettings = {
      LC_ADDRESS = mkForce "pt_BR.UTF-8";
      LC_IDENTIFICATION = mkForce "pt_BR.UTF-8";
      LC_MEASUREMENT = mkForce "pt_BR.UTF-8";
      LC_MONETARY = mkForce "pt_BR.UTF-8";
      LC_NAME = mkForce "pt_BR.UTF-8";
      LC_NUMERIC = mkForce "pt_BR.UTF-8";
      LC_PAPER = mkForce "pt_BR.UTF-8";
      LC_TELEPHONE = mkForce "pt_BR.UTF-8";
      LC_TIME = mkForce "en_US.UTF-8";
    };
  };
}
