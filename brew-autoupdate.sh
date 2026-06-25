#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

log_dir="${HOME}/Library/Logs/brewcask-autoupdate"
log_file="${log_dir}/brew-autoupdate.log"

mkdir -p "${log_dir}"

{
  printf '\n[%s] Starting Homebrew auto-update\n' "$(date '+%Y-%m-%d %H:%M:%S %z')"
  brew upgrade && brew update
  printf '[%s] Finished Homebrew auto-update\n' "$(date '+%Y-%m-%d %H:%M:%S %z')"
} >> "${log_file}" 2>&1
