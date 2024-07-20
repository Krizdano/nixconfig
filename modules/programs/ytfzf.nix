{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, coreutils
, curl
, fzf
, gnused
, jq
, mpv
, yt-dlp
, ueberzugpp
}:

stdenv.mkDerivation rec {
  pname = "ytfzf";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "pystardust";
    repo = "ytfzf";
    rev = "0857c7409e8ba8307bfe9e1b218f4fbbd4b1db07";
    hash = "sha256-rwCVOdu9UfTArISt8ITQtLU4Gj2EZd07bcFKvxXQ7Bc=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installFlags = [
    "PREFIX="
    "DESTDIR=${placeholder "out"}"
    "doc"
    "addons"
  ];

  postInstall = ''
    wrapProgram "$out/bin/ytfzf" \
      --prefix PATH : ${lib.makeBinPath [
        coreutils curl fzf gnused jq mpv yt-dlp ueberzugpp
      ]} \
      --set YTFZF_SYSTEM_ADDON_DIR "$out/share/ytfzf/addons"
      cd $out/bin
      sed -i 's/dmenu -i -l 30/dmenu -i -l 8/g' .ytfzf-wrapped
  '';

  meta = with lib; {
    description = "A posix script to find and watch youtube videos from the terminal";
    homepage = "https://github.com/pystardust/ytfzf";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [ dotlambda ];
  };
}
