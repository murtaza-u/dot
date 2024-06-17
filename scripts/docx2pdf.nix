{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "docx2pdf" ''
  file="$1"
  if [[ ! -f "$file" ]]; then
    echo "file $file does not exist"
    exit 1
  fi

  exec ${pkgs.libreoffice}/bin/soffice --headless \
    --convert-to pdf:writer_pdf_Export \
    "$file"
''
