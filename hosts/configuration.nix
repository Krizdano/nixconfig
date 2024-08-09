{ pkgs, lib, inputs, ... }:

{
  imports = [
    ../modules/services/greetd.nix
  ]
  ++ (import ../modules/security);

  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = false;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      use-xdg-base-directories = true;
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  # move nix daemon from ram to disk
  systemd.services.nix-daemon = {
    environment = {
      #location for temporary files
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      # create /var/cache/nix automatically on nix deamon start
      CacheDirectory = "nix";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  #tty
  console = {
    useXkbConfig = true;
  };


  # dconf (for gtk apps to work properly)
  programs.dconf = {
    enable = true;
  };


  # git 
  programs.git.enable = true;

  #pam
  security.pam.services = {
    swaylock = { }; # for swaylock to work 
  };


  programs.zsh.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # remove nano
  programs.nano = {
    enable = false;
  };

  environment.systemPackages = with pkgs; [
    git-crypt
    wget
  ];

  # remove default packages
  environment.defaultPackages = [ ];

  # bash
  programs.bash = {
    completion = {
      enable = true;
    };
    enableLsColors = true;
    promptInit = ''eval "$(starship init bash)"'';
  };


  # fonts
  fonts.packages = with pkgs; [
    carlito
    vegur
    noto-fonts
    office-code-pro
    (nerdfonts.override { fonts = [ "Ubuntu" "SourceCodePro" ]; }) # for swaybar config
  ];



  environment = {
    pathsToLink = [ "/share/zsh" ];
    shells = with pkgs; [ zsh ];
    variables = {
      TERMINAL = "kitty";
      NIX_REMOTE = "daemon"; # force nix command to call the daemon
      EDITOR = "emacsclient";
      VISUAL = "emacsclient";
    };
  };

  # pipewire 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = {
      enable = true;
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # authorisation
  security.polkit.enable = true;

  # dbus 
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr ]; # for gpg authorisation
  };

  #xdg
  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "image/png" = "imv";
      };
    };
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [ "hyprland" "gtk" ];
        };
      };
    };
  };


  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/keys/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/keys/ssh_host_rsa_key";
        type = "rsa";
        bits = "4096";
      }
    ];
  };


  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPortRanges = [
      # kdconnect
      { from = 1714; to = 1764; }
    ];
    allowedTCPPorts = [
      #8080 8000 
    ];
  };


  networking.firewall.allowedUDPPortRanges = [
    # kdeconnect 
    { from = 1741; to = 1764; }
  ];


  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
    '';
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

} # end of configuration
