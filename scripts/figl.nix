{ pkgs ? import <nixpkgs> { } }:
let
  figletFonts = pkgs.fetchFromGitHub {
    owner = "xero";
    repo = "figlet-fonts";
    rev = "a6d2db1a3ee88bec3518214e851825fc4495ac84";
    sha256 = "sha256-dAs7N66D2Fpy4/UB5Za1r2qb1iSAJR6TMmau1asxgtY=";
  };
in
pkgs.writeShellScriptBin "figl" ''
  clear=$'\033[2J'
  top=$'\033[H'

  trap 'setterm --cursor on; stty echo; echo ''${clear}; exit; trap -- - SIGINT SIGTERM' SIGTERM SIGINT

  echo "''${clear}"
  while true; do
    echo "''${top}"
    stty -echo
    setterm --cursor off
    ${pkgs.figlet}/bin/figlet -f "${figletFonts}/future.tlf" -c -t "$*" | ${pkgs.lolcat}/bin/lolcat 2>/dev/null
    setterm --cursor off
    sleep 3
  done
''
