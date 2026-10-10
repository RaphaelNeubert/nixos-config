set -euo pipefail

if (( $# > 1 )); then
  echo "Usage: project-workspace [DIRECTORY]" >&2
  exit 2
fi

caller_address=
if [[ -n ${KITTY_WINDOW_ID:-} ]]; then
  caller_address=$(hyprctl activewindow -j | jq -r 'if .class == "kitty" then .address else empty end')
fi

if (( $# == 0 )); then
  directory=$(printf '%s%s\n' '~' '/tu/hrl2/manager-worker' | rofi -dmenu -p "Project directory") || exit 0
  [[ -n $directory ]] || exit 0
  directory=${directory/#\~/$HOME}
else
  directory=$1
fi

if [[ ! -d $directory ]]; then
  echo "project-workspace: not a directory: $directory" >&2
  exit 1
fi

project_dir=$(realpath "$directory")
dev_flake=/etc/nixos/flake-templates/uv-flake

shell_quote() {
  printf "'%s'" "${1//\'/\'\\\'\'}"
}

lua_quote() {
  local value=$1
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  value=${value//$'\n'/\\n}
  value=${value//$'\r'/\\r}
  printf '"%s"' "$value"
}

launch() {
  local workspace=$1
  shift

  local command
  command="kitty --directory $(shell_quote "$project_dir")"
  local arg
  for arg in "$@"; do
    command+=" $(shell_quote "$arg")"
  done

  hyprctl dispatch "hl.dsp.exec_cmd($(lua_quote "[workspace $workspace silent] $command"))" >/dev/null
}

launch 1 zsh -lc "exec nix develop $(shell_quote "$dev_flake") --command nvim"
launch 1 zsh -lc "exec nix develop $(shell_quote "$dev_flake") --command opencode"
launch 3 zsh -lc "exec nix develop $(shell_quote "$dev_flake")"
launch 8 zsh -lc "exec nix develop $(shell_quote "$dev_flake") --command uv run tensorboard --logdir runs --load_fast=true"

if [[ -n $caller_address ]]; then
  hyprctl dispatch "hl.dsp.window.close({ window = $(lua_quote "address:$caller_address") })" >/dev/null
fi
