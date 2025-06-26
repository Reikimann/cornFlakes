#! @bash@/bin/sh

set -o errexit
set -o nounset

PROGRAM_NAME="swww-utils"

show_help () {
  @coreutils@/bin/cat << EOF
Swww Wallpaper Helper Utility

Usage:
  $PROGRAM_NAME <COMMAND> [OPTIONS]

Commands:
  switch      Switches to a new wallpaper
  randomize   Automatically switches between wallpapers

Options:
  -h, --help  Prints help message

Use '$PROGRAM_NAME <COMMAND> --help' for more details on a specific subcommand.
EOF
}

switch_help () {
  @coreutils@/bin/cat << EOF
Switches to a random wallpaper from \$RICE_WALL_DIR or a specified path

Usage:
  $PROGRAM_NAME switch [OPTIONS]

Options:
  -h, --help            Prints help message
  -p, --path <PATH>     Path to either a picture or the directory to choose from

Environment variables:
  RICE_WALL_DIR         Path to wallpaper folder (used if no path is provided)
EOF
}

randomize_help () {
  @coreutils@/bin/cat << EOF
Switches to a random wallpaper in the background at a configurable interval

Usage:
  $PROGRAM_NAME randomize [OPTIONS]

Options:
  -h, --help               Prints help message
  -p, --path <PATH>        Path to the directory to choose from
  -i, --interval <NUMBER>  Sets the interval for auto-switching (allows s/m/h/d time units) [default: 300s]

Environment variables:
  RICE_WALL_DIR            Path to wallpaper folder (used if no path is provided)
EOF
}

changebg ()
{
  @swww@/bin/swww img "$1" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type grow \
    --transition-duration 1 \
    --transition-fps 90 \
    --transition-step 255 \
    --transition-pos top-right
}

print_error () {
  @coreutils@/bin/echo "$PROGRAM_NAME: $1" >&2
  exit 1
}


if [[ $# -lt 1 ]]; then
  show_help
  exit 1
fi

bg_path="$RICE_WALL_DIR"
interval=300s

case "$1" in
  switch)
    shift

    PARSED=$(@getopt@/bin/getopt -o "hp:" --long "help,path:" -n "$PROGRAM_NAME" -- "$@")
    eval set -- "$PARSED"

    while [[ $# -gt 0 ]]; do
      case "$1" in
        -h|--help) switch_help; exit 0 ;;
        -p|--path) bg_path=${2/#\~/$HOME}; shift 2 ;;
        --) shift; break ;;
        *) print_error "Unknown option: '$1'. Try '$PROGRAM_NAME switch -h' for help." ;;
      esac
    done

    if [[ -d $bg_path ]]; then
      WALLPAPER=$(@fd@/bin/fd --type=f . $bg_path | @coreutils@/bin/shuf -n 1)
      changebg "$WALLPAPER"
    elif [[ -f $bg_path ]]; then
      changebg "$bg_path"
    else
      print_error "No such file or directory: $bg_path"
    fi
    ;;

  randomize)
    shift

    PARSED=$(@getopt@/bin/getopt -o "hi:p:" --long "help,interval:,path:" -n "$PROGRAM_NAME" -- "$@")
    eval set -- "$PARSED"

    while [[ $# -gt 0 ]]; do
      case "$1" in
        -h|--help) randomize_help; exit 0 ;;
        -p|--path) bg_path=${2/#\~/$HOME}; shift 2 ;;
        -i|--interval)
          interval="$2"
          re="^[0-9]+([.][0-9]+)?[smhd]?$"
          [[ $interval =~ $re ]] || print_error "Not a number: '$2'"
          shift 2
          ;;
        --) shift; break ;;
        *) print_error "Unknown option: '$1'. Try '$PROGRAM_NAME switch -h' for help." ;;
      esac
    done

    [[ -d $bg_path ]] || print_error "Provided path is not a directory: '$bg_path'"
    images=($(@fd@/bin/fd --type f . "$bg_path" | @coreutils@/bin/shuf))

    while true; do
      for img in "${images[@]}"; do
        changebg "$img"
        @coreutils@/bin/sleep $interval
      done
    done
    ;;
  -h|--help) show_help; exit 0 ;;
  *) print_error "Unknown option: '$1'. Try '$PROGRAM_NAME switch -h' for help." ;;
esac
