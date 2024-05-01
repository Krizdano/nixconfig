{ pkgs, config, ... }:

{

  # shell(zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    autocd = true;
    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=always";
      nt = ''pushd /persist/home; find nixconfig/notes -name '*.md' | fzf --preview="glow {}" | xargs vi; popd'';
      sc = ''pushd /persist/home; find nixconfig/config/scripts -name '*.sh' | fzf --preview="pistol {}" | xargs vi; popd'';
      notes = ''glow  /persist/home/nixconfig/notes'';
      conf = ''pushd /persist/home; find nixconfig -name '*.nix' | fzf --preview="pistol {}" | xargs vi; popd''; # nixos configuration
      # nixos rebuild
      re = "doas nixos-rebuild switch --flake /persist/home/nixconfig#$(hostname)";

      # nix-shell with rust development tools
      rus =
        " 
          	   cp ~/nixconfig/modules/languages/rust/{flake.nix,flake.lock} ~/testfolder/projects/rust/\
          	   cd ~/rust \
          	   nix develop -c $SHELL\
                     ";
      # youtube
      yt = "ytfzf -t --thumb-viewer=kitty -f -s --detach -l --preview-side=right";

      # update nixos using flakes
      update = "doas nix flake update /persist/home/nixconfig/";

      pg = "pass git push";

      # w3m with google search 
      gg = "w3m google.com";

      search = "nix search --inputs-from /persist/home/nixconfig nixpkgs";
    };

    completionInit = "autoload -Uz compinit
                      zstyle ':completion:*' menu select
                      zmodload zsh/complist
                      compinit
                      ";


    envExtra = ''
      	       export NIXPKGS_ALLOW_UNFREE=1
      	     '';

    defaultKeymap = "viins";
    # profileExtra = ''
    #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
    #    exec Hyprland
    #   fi
    # '';
    initExtra =
      ''eval "$(starship init zsh)"

      export KEYTIMEOUT=1

      # launch w3m with a search query

      ww(){
      "w3m" "http://localhost:8080/search?q=$*"
      }

      unsetopt BEEP

      # vi mode
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # custom syntax highlighting
      ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets pattern root line)

      # Declare the variable
      typeset -A ZSH_HIGHLIGHT_STYLES

      # To have paths colored instead of underlined
      ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'

      ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta,bold'

      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta,bold'

      ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'

      ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[global-alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
      '';
  };

}
