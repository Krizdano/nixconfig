{ pkgs, config, ... }: {

  imports = [
  ]
  ++ (import ../programs)
  ++ (import ../shell);


  # fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      fg = "#cdd6f4";
      bg = "#1e1e2e";
      hl =  "#f38ba8";
      "fg+" = "#cdd6f4";
      "bg+" = "#313244";
      "hl+" = "#f38ba8";
      info = "#cba6f7";
      prompt = "#cba6f7";
      pointer = "#f5e0dc";
      marker = "#f5e0dc";
      spinner = "#f5e0dc";
      header = "#f38ba8";
    };
  };


  home = {
    packages = with pkgs; [
      w3m # terminal browser
      glow # terminal markdown reader
      xdg-utils # for xdg-open to work
      ytfzf # terminal youtube 
      glib # gsettings
      toot # mastodon cli client
      wtype
      ripgrep
      swaylock
      wl-clipboard
      fastfetch
      unzip
      virt-manager
      gdu # disk management
      tdesktop # telegram
      signal-desktop
      scripts
      jmtpfs
      imv
    ];

    file = {
      ".config/scripts".source = ../../config/scripts;
      ".config/ytfzf/subscriptions".source = ../../config/ytfzf/subscriptions;
      "${config.xdg.dataHome}/w3m/keymap".source = ../../config/w3m/keymap;
    };

    sessionVariables = {

      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      W3M_DIR = "${config.xdg.dataHome}/w3m";

    };

    activation = {
      firefox-search-engin = config.lib.dag.entryBefore [ "checkLinkTargets" ] ''
         	  if test -f $HOME/.mozilla/firefox/default/search.json.mozlz4;
         	   then rm $HOME/.mozilla/firefox/default/search.json.mozlz4
        	    fi'';
      report-changes = config.lib.dag.entryAnywhere ''
            ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
        		'';
    };
    stateVersion = "23.11";
  };


  #default home directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      templates = null;
      publicShare = null;
      music = null;
      desktop = null;
      extraConfig = {
        XDG_OTHER_DIR = "${config.home.homeDirectory}/Other";
      };
    };
  };

  # themes
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme.override {
        tweaks = [
          "black"
        ];
      };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 29;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "black"; };
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

} # end of home-manager
