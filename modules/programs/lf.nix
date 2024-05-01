{ pkgs, ... }: {

  programs.lf = {
    enable = true;
    settings = {
      icons = true;
      #color256 = true;
      ignorecase = true;
      # drawbox = true;
    };
    keybindings = {
      # certain keybindings
      "." = "set hidden!";
      "<enter>" = "shell";
      "o" = "$glow -p $f";
      "SS" = "delete";
      "s" = "cut";
      ";" = "paste";
      "j" = "copy";
      "b" = "$swayimg $f";
      "n" = "down";
      "e" = "up";
      "m" = "updir";
      "i" = "open";
      "f" = "$$EDITOR $f";
      "p" = "rename";


    };
    #commands = {
    #  follow_link = ''
    #  %{{lf -remote "send ''${id} select '$(readlink $f)'"}}
    #  '';
    # };

    extraConfig = ''
      set previewer ~/.config/lf/lf_kitty_preview
      set cleaner ~/.config/lf/lf_kitty_clean
      set cursorpreviewfmt "\033[7m"
    '';
  };

  home = {

    packages = with pkgs; [
      file
      swayimg
    ];

    file.".config/lf/lf_kitty_clean" = {
      text = ''
        #!/usr/bin/env bash

        kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
      executable = true;
    };


    file.".config/lf/lf_kitty_preview" = {
      text = ''
        #!/usr/bin/env bash
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
            kitty +kitten icat --silent --stdin no --transfer-mode file --place ''${w}x''${h}@''${x}x''${y} "$file" < /dev/null > /dev/tty
            exit 1
        fi

        pistol "$file"

      '';

      executable = true;
    };

    file.".config/lf/icons" = {
      text = ''
        # file types (with matching order)
          ln             # LINK
          or             # ORPHAN
          tw             # STICKY_OTHER_WRITABLE
          ow             # OTHER_WRITABLE
          st      t       # STICKY
          di             # DIR
          pi      p       # FIFO
          so      s       # SOCK
          bd      b       # BLK
          cd      c       # CHR
          su      u       # SETUID
          sg      g       # SETGID
          ex             # EXEC
          fi             # FILE
              
         # file extensions (vim-devicons)
          *.styl          
          *.sass          
          *.scss          
          *.htm           
          *.html          
          *.slim          
          *.haml          
          *.ejs           
          *.css           
          *.less          
          *.md            
          *.mdx           
          *.markdown      
          *.rmd           
          *.json          
          *.webmanifest   
          *.js            
          *.mjs           
          *.jsx           
          *.rb            
          *.gemspec       
          *.rake          
          *.php           
          *.py            
          *.pyc           
          *.pyo           
          *.pyd           
          *.coffee        
          *.mustache      
          *.hbs           
          *.conf          
          *.ini           
          *.yml           
          *.yaml          
          *.toml          
          *.bat           
          *.mk            
          *.jpg           
          *.jpeg          
          *.bmp           
          *.png           
          *.webp          
          *.gif           
          *.ico           
          *.twig          
          *.cpp           
          *.c++           
          *.cxx           
          *.cc            
          *.cp            
          *.c             
          *.cs            
          *.h             
          *.hh            
          *.hpp           
          *.hxx           
          *.hs            
          *.lhs           
          *.nix           
          *.lua           
          *.java          
          *.sh            
          *.fish          
          *.bash          
          *.zsh           
          *.ksh           
          *.csh           
          *.awk           
          *.ps1           
          *.ml            λ
          *.mli           λ
          *.diff          
          *.db            
          *.sql           
          *.dump          
          *.clj           
          *.cljc          
          *.cljs          
          *.edn           
          *.scala         
          *.go            
          *.dart          
          *.xul           
          *.sln           
          *.suo           
          *.pl            
          *.pm            
          *.t             
          *.rss           
          '*.f#'          
          *.fsscript      
          *.fsx           
          *.fs            
          *.fsi           
          *.rs            
          *.rlib          
          *.d             
          *.erl           
          *.hrl           
          *.ex            
          *.exs           
          *.eex           
          *.leex          
          *.heex          
          *.vim           
          *.ai            
          *.psd           
          *.psb           
          *.ts            
          *.tsx           
          *.jl            
          *.pp            
          *.vue           ﵂
          *.elm           
          *.swift         
          *.xcplayground  
          *.tex           ﭨ
          *.r             ﳒ
          *.rproj         鉶
          *.sol           ﲹ
          *.pem           
              
                                                                               # file names (vim-devicons) (case-insensitive not supported in lf)
          *gruntfile.coffee       
          *gruntfile.js           
          *gruntfile.ls           
          *gulpfile.coffee        
          *gulpfile.js            
          *gulpfile.ls            
          *mix.lock               
          *dropbox                
          *.ds_store              
          *.gitconfig             
          *.gitignore             
          *.gitattributes         
          *.gitlab-ci.yml         
          *.bashrc                
          *.zshrc                 
          *.zshenv                
          *.zprofile              
          *.vimrc                 
          *.gvimrc                
          *_vimrc                 
          *_gvimrc                
          *.bashprofile           
          *favicon.ico            
          *license                
          *node_modules           
          *react.jsx              
          *procfile               
          *dockerfile             
          *docker-compose.yml     
          *rakefile               
          *config.ru              
          *gemfile                
          *makefile               
          *cmakelists.txt         
          *robots.txt             ﮧ
              
         # file names (case-sensitive adaptations)
          *Gruntfile.coffee       
          *Gruntfile.js           
          *Gruntfile.ls           
          *Gulpfile.coffee        
          *Gulpfile.js            
          *Gulpfile.ls            
          *Dropbox                
          *.DS_Store              
          *LICENSE                
          *React.jsx              
          *Procfile               
          *Dockerfile             
          *Docker-compose.yml     
          *Rakefile               
          *Gemfile                
          *Makefile               
          *CMakeLists.txt         
              
                                                                                                                                                     # file patterns (vim-devicons) (patterns not supported in lf)
          # .*jquery.*\.js$         
          # .*angular.*\.js$        
          # .*backbone.*\.js$       
          # .*require.*\.js$        
          # .*materialize.*\.js$    
          # .*materialize.*\.css$   
          # .*mootools.*\.js$       
          # .*vimrc.*               
          # Vagrantfile$            
              
         # file patterns (file name adaptations)
          *jquery.min.js          
          *angular.min.js         
          *backbone.min.js        
          *require.min.js         
          *materialize.min.js     
          *materialize.min.css    
          *mootools.min.js        
          *vimrc                  
          Vagrantfile             
              
                                                                                                                                                     # archives or compressed (extensions from dircolors defaults)
          *.tar    
          *.tgz   
          *.arc    
          *.arj   
          *.taz   
          *.lha   
          *.lz4   
          *.lzh   
          *.lzma  
          *.tlz   
          *.txz   
          *.tzo   
          *.t7z   
          *.zip   
          *.z     
          *.dz    
          *.gz    
          *.lrz   
          *.lz    
          *.lzo   
          *.xz    
          *.zst   
          *.tzst  
          *.bz2   
          *.bz    
          *.tbz   
          *.tbz2  
          *.tz    
          *.deb   
          *.rpm   
          *.jar   
          *.war   
          *.ear   
          *.sar   
          *.rar   
          *.alz   
          *.ace   
          *.zoo   
          *.cpio  
          *.7z    
          *.rz    
          *.cab   
          *.wim   
          *.swm   
          *.dwm   
          *.esd   
              
         # image formats (extensions from dircolors defaults)
          *.jpg   
          *.jpeg  
          *.mjpg  
          *.mjpeg 
          *.gif   
          *.bmp   
          *.pbm   
          *.pgm   
          *.ppm   
          *.tga   
          *.xbm   
          *.xpm   
          *.tif   
          *.tiff  
          *.png   
          *.svg   
          *.svgz  
          *.mng   
          *.pcx   
          *.mov   
          *.mpg   
          *.mpeg  
          *.m2v   
          *.mkv   
          *.webm  
          *.ogm   
          *.mp4   
          *.m4v   
          *.mp4v  
          *.vob   
          *.qt    
          *.nuv   
          *.wmv   
          *.asf   
          *.rm    
          *.rmvb  
          *.flc   
          *.avi   
          *.fli   
          *.flv   
          *.gl    
          *.dl    
          *.xcf   
          *.xwd   
          *.yuv   
          *.cgm   
          *.emf   
          *.ogv   
          *.ogx   
              
         # audio formats (extensions from dircolors defaults)
          *.aac   󰈣
          *.au    󰈣
          *.flac  󰈣
          *.m4a   󰈣
          *.mid   󰈣
          *.midi  󰈣
          *.mka   󰈣
          *.mp3   󰈣
          *.mpc   󰈣
          *.ogg   󰈣
          *.ra    󰈣
          *.wav   󰈣
          *.oga   󰈣
          *.opus  󰈣
          *.spx   󰈣
          *.xspf  󰈣
              
         # other formats
          *.pdf    
          *.iso   󰋊 
          *.img   
          *.lock  
      '';
    };

  };


}
              
              
              
