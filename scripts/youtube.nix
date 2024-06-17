{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "youtube" ''
  mkdir -p "$HOME/Videos" "$HOME/Music"

  video() {
    ${pkgs.yt-dlp}/bin/yt-dlp \
      -o "$HOME/Videos/%(title)s.%(ext)s" \
      -f "bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]" \
      "$*"
  }

  audio() {
    ${pkgs.yt-dlp}/bin/yt-dlp \
      -o "$HOME/Music/%(title)s.%(ext)s" \
      -x -f bestaudio/best \
      "$@"
  }

  ######## bash completion context ########
  root=(audio video)
  comp() {
    local arg="$1"
    shift
    for c in "$@"; do
      [[ "''${c:0:''${#arg}}" == "''${arg,,}" ]] && echo "$c"
    done
  }
  if [[ -n "$COMP_LINE" ]]; then
    if [[ "$1" == "$3" ]]; then
      comp "$2" "''${root[@]}"
      exit 0
    fi
    exit 0
  fi

  numargs="''${#@}"
  if [[ "$numargs" -lt 1 ]]; then
    echo "very few arguments"
    exit 1
  fi

  cmd="$1"; shift

  case "$cmd" in
    "audio") audio "$*" ;;
    "video") video "$*" ;;
    *)       echo "invalid command: $cmd" ;;
  esac
''
