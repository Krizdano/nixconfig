{ pkgs, secrets, ... }:
let
  user = secrets.users;
in
{

  programs.git = {
    enable = true;
    diff-so-fancy = {
      enable = true;
    };
    signing = {
      key = null;
      signByDefault = true;
    };

    userName = user.primary.GitUserName;
    userEmail = user.primary.GitUserEmail;
  };

  home.packages = with pkgs; [ git-crypt ];

}
