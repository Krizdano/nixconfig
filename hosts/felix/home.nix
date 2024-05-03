{ pkgs, ... }: {

  imports = [
    ../../modules/home/default.nix
    ../../modules/home/persist.nix
    ../../modules/WindowManagers/hyprland/default.nix
  ]
  ++ (import ../../modules/services);

  home.packages = with pkgs; [
    oi # cli program for quick google search
    tt # cli typing test
    redqu # media centric reddit client 
    keepassxc
    nitch
    unzip
    virt-manager
    gdu # disk management
    tdesktop # telegram
    signal-desktop
    scripts
    jmtpfs
    imv
  ];

}
