{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "media-duration" ''
  get_dur() {
    file="$1"
    ${pkgs.ffmpeg}/bin/ffprobe \
      -v quiet \
      -print_format json \
      -show_format \
      "$file" | ${pkgs.jq}/bin/jq -r '.format.duration'
  }

  sum=0
  for f in "$@"; do
    if [ -f "$f" ]; then
      seconds="$(get_dur "$f")"
      if [ "$seconds" != "null" ]; then
        sum="$(echo "$sum + $seconds" | bc -l)"
      fi
    fi
  done

  sum="$(printf "%.0f" "$sum")"

  if [ "$sum" -gt 86400 ]; then
    printf "%.2f days\n" "$(echo "$sum / 86400" | bc -l)"
  elif [ "$sum" -gt 3600 ]; then
    printf "%.2f hrs\n" "$(echo "$sum / 3600" | bc -l)"
  elif [ "$sum" -gt 60 ]; then
    printf "%.2f min\n" "$(echo "$sum / 60" | bc -l)"
  else
    echo "$sum sec"
  fi
''
