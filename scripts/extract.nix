{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "extract" ''
  if [[ -z "$1" ]]; then
    echo "ex <compressed>"
    exit 1
  fi

  if [[ ! -f "$1" ]]; then
    echo "Invalid file: $1"
    exit 1
  fi

  case "$1" in
    *.tar.bz2) tar xjf                           "$1" ;;
    *.tar.gz)  tar xzf                           "$1" ;;
    *.tar)     tar xf                            "$1" ;;
    *.tbz2)    tar xjf                           "$1" ;;
    *.tgz)     tar xzf                           "$1" ;;
    *.tar.xz)  tar xf                            "$1" ;;
    *.bz2)     ${pkgs.bzip2}/bin/bunzip2         "$1" ;;
    *.rar)     ${pkgs.unrar-wrapper}/bin/unrar x "$1" ;;
    *.gz)      ${pkgs.gzip}/bin/gunzip           "$1" ;;
    *.zip)     ${pkgs.unzip}/bin/unzip           "$1" ;;
    *.Z)       ${pkgs.gzip}/bin/uncompress       "$1" ;;
    *.tar.zst) ${pkgs.zstd}/bin/unzstd           "$1" ;;
    *.7z)      ${pkgs.p7zip}/bin/7z x            "$1" ;;
    *.deb)     ar x                              "$1" ;;
    *)         echo "'$1' cannot be extracted via ex()"; exit 1 ;;
  esac
''
