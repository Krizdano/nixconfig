{ ... }:

{
  home.persistence."/persist/home/" = {
    allowOther = true;
    directories = [
      ".mozilla"
      ".ssh"


      { directory = ".config/lobster"; method = "symlink"; }
      { directory = ".config/kdeconnect"; method = "symlink"; }
      { directory = ".config/Signal"; method = "symlink"; }
      { directory = ".config/keepassxc"; method = "symlink"; }
      { directory = ".config/epr"; method = "symlink"; }

      # # android studio
      # ".config/.android"
      # ".config/Android Open Source Project"
      # ".config/Google"
      # ".m2"

      ".config/emacs"


      { directory = ".cache/mesa_shader_cache"; method = "symlink"; }
      { directory = ".cache/mozilla"; method = "symlink"; }
      { directory = ".cache/nix"; method = "symlink"; }
      { directory = ".cache/nvim"; method = "symlink"; }

      ".local/share/gnupg"
      ".local/share/flatpak"
      ".local/share/direnv"
      ".local/share/android"
      ".local/share/w3m"
      ".local/share/emacs-backup"

      { directory = ".cache/ytfzf"; method = "symlink"; }
      { directory = ".local/share/TelegramDesktop"; method = "symlink"; }
      { directory = ".local/share/zsh"; method = "symlink"; }
      ".local/state/wireplumber"

      # android studio
      # ".local/share/Android Open Source Project"
      # ".local/share/Google"
      # ".local/share/kotlin"
      # "Android"
      # "AndroidStudioProjects"



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
