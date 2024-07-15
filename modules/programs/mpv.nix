{ pkgs, ... }: {

  programs.mpv = {
    enable = true;
    # package = pkgs.unstable.mpv;
    config = {
      cache = "yes";
      cache-secs = "120";
      hwdec = "auto-safe";
      gpu-context = "wayland";
      # ytdl-format= "bestvideo[height<=?1080]+bestaudio/best";
      sub-file-paths = "~/Documents/subtitles";
      sub-auto = "all";
    };
    defaultProfiles = [ "gpu-hq" ];
    scripts = with pkgs.mpvScripts; [
      # for mpv scripts
      quality-menu
    ];
  };



}
