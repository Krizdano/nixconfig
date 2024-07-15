{ pkgs, user, secrets, ... }:
let
  inherit (secrets) users;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./rollback.nix
      ../../modules/programs/plymouth
      ../../modules/services/searx.nix
    ];

  # adb
  programs.adb.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    extraConfig = "DNS=194.242.2.4 \n DNSOverTLS=opportunistic";

  };

  #opengl
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
    extraPackages32 = with pkgs; [
      amdvlk
    ];
  };

  # user
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root = {
        inherit (users.root) hashedPassword;
      };
      ${user} = {
        inherit (users.primary) hashedPassword;
        isNormalUser = true;
        extraGroups = [ "jupyter" "networkmanager" "wheel" "video" "libvirtd" "audio" "adbusers" ];
        packages = with pkgs; [
          # user packages 
        ];
      };
    };
  };

  services.flatpak.enable = true;

  networking = {
    hostName = "Felix";
    networkmanager = {
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
    useDHCP = false;
    wireless = {
      iwd = {
        enable = true;
        settings = {
          General = {
            AddressRandomization = "network";
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };
  };

  # bluetooth 
  hardware.bluetooth.enable = true;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      timeout = 0;
      # UEFI settings
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    tmp.useTmpfs = true;
    # get latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = { "vm.swappiness" = 10; };
    # consoleLogLevel = 3;
    # kernelParams = [ "quiet" ];
  };


  #virtualisation
  virtualisation = {
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu.ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # laptop screen brightness
  programs.light.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # linuxKernel.packages.linux_6_3.v4l2loopback
  ];

} # end of configuration

