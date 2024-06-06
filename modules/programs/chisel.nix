# simple.nix
{pkgs, ...}:
  pkgs.stdenv.mkDerivation {
    name = "chisel";

    src = ./.;

		configurePhase = ''
		 mkdir obj
		 mkdir bin
		'';

    installPhase = ''
		  # ls $out
      mkdir -p $out/bin
      cp bin/chisel  $out/bin/chisel
			'';
  }
