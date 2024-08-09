{ pkgs, ...}: {

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [  epkgs.vterm ];
  };

  home.packages = with pkgs; [
    rust-analyzer
    clang-tools
    clang
    nil
    zls
    cargo
    rustc
    python312Packages.python-lsp-server
  ];

  services.emacs = {
    enable = true;
    startWithUserSession = true;
  };
}
