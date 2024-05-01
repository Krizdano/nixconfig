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
    rev = "a67ba26482b2a27e12b83053a6048b9d78e20c98";
    hash = "sha256-zLsMDrxa9mAtxjwA37+DNPjW91mC3efomaF6xd
U4iZ
E=";
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
