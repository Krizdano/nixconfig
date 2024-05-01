{ pkgs, secrets, ... }: 
let
user = secrets.users;
in
{

  programs.git = {
    enable = true;
    # diff-so-fancy = {
    #   enable = true;
    # };
    delta = {
      enable = true;
      options = {
        side-by-side = false;
        syntax-theme = "Catpuccin-mocha";
      };
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
