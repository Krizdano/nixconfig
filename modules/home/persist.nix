{ ... }:

{
  home.persistence."/persist/home/" = {
    allowOther = true;
    directories = [
      ".android"
      ".mozilla"
      ".ssh"
      ".w3m"


      ".config/neofetch"
      ".config/htop"
      ".config/kdeconnect"
      ".config/libvirt"
      ".config/lobster"
      ".config/toot"
      ".config/gurk"
      ".config/Signal"
      ".config/keepassxc"
      ".config/epr"

      # # android studio
      # ".config/.android"
      # ".config/Android Open Source Project"
      # ".config/Google"
      # ".m2"

      ".cache/dconf"
      ".cache/fontconfig"
      ".cache/libvirt"
      ".cache/virtmanager"
      ".cache/mesa_shader_cache"
      ".cache/mozilla"
      ".cache/nix"
      ".cache/nvim"
      ".cache/ytfzf"
      ".cache/qtshadercache-x86_64-little_endian-lp64"

      ".local/share/TelegramDesktop"
      ".local/share/zsh"
      ".local/share/applications"
      ".local/share/gurk"
      ".local/share/gnupg"
      ".local/share/flatpak"

      # android studio
      # ".local/share/Android Open Source Project"
      # ".local/share/Google"
      # ".local/share/kotlin"
      # "Android"
      # "AndroidStudioProjects"


      ".local/state/wireplumber"

      {
        directory = "nixconfig";
        method = "symlink";
      }

      {
        directory = "Downloads";
        method = "symlink";
      }

      {
        directory = "Documents";
        method = "symlink";
      }

      {
        directory = "Videos";
        method = "symlink";
      }

      {
        directory = "testfolder";
        method = "symlink";
      }

      {
        directory = "Pictures";
        method = "symlink";
      }

      {
        directory = "Other";
        method = "symlink";
      }

    ];
    files = [

      ".config/gh/hosts.yml"
      ".config/mimeapps.list"

    ];
  };
}
