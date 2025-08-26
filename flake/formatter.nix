{
  writeShellApplication,
  alejandra,
  deadnix,
  statix,
}:
writeShellApplication {
  name = "lint";
  runtimeInputs = [
    alejandra
    deadnix
    statix
  ];
  text = ''
    format_file() {
      alejandra "$1"
      deadnix -e "$1"
      statix fix "$1"
    }

    if [ -d "$1" ]; then
      find "$1" -iname "*.nix" | while read -r file; do
        format_file "$file"
      done
    fi

    if [ -n "$1" ] && [ -f "$1" ]; then
      format_file "$1"
    fi

    find . -iname "*.nix" | while read -r file; do
      format_file "$file"
    done
  '';
}
