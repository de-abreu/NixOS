# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs
, filter
, ...
}: {
  imports =
    let
      modules = filter ./modules;
    in
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
    ]
    ++ modules;

  # Bootloader.
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
      enableCryptodisk = true;
    };
    initrd = {
      secrets."/boot/crypto_keyfile.bin" = null;
      luks.devices."luks-f9f39611-cda8-43a3-bf67-d2266ecfd5d5".keyFile = "/boot/crypto_keyfile.bin";
    };
  };

  networking = {
    hostName = "nixos"; # Define the hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enable networking
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.11";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true; # Enable the X11 windowing system.

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        # Configure keymap in X11
        layout = "br";
        variant = "";
      };
    };
    # Enable automatic login for the user.
    displayManager.autoLogin = {
      enable = true;
      user = "user";
    };
    printing.enable = true; # Enable CUPS to print documents.
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ]; # "wheel adds the user to the sudoers group"
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      keepassxc # password manager

      # Terminal related applications
      bat
      bottom # Process monitor
      curl
      fira-code-nerdfont
      fish
      kitty
      tmux
      tree
      wget

      # Watch series
      celluloid
      fragments
    ];
    variables = {
      TERM = "kitty";
    };
  };

  system.stateVersion = "24.11";
}
