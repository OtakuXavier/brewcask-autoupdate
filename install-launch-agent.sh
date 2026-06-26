#!/usr/bin/env bash
set -euo pipefail

label="com.otakuxavier.brewcask-autoupdate"
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script_path="${repo_dir}/brew-autoupdate.sh"
launch_agents_dir="${HOME}/Library/LaunchAgents"
plist_path="${launch_agents_dir}/${label}.plist"
execution_hour="${BREW_AUTOUPDATE_HOUR:-8}"
execution_minute="${BREW_AUTOUPDATE_MINUTE:-0}"

if ! [[ "${execution_hour}" =~ ^[0-9]+$ ]] || (( execution_hour < 0 || execution_hour > 23 )); then
  echo "BREW_AUTOUPDATE_HOUR must be an integer from 0 to 23." >&2
  exit 1
fi

if ! [[ "${execution_minute}" =~ ^[0-9]+$ ]] || (( execution_minute < 0 || execution_minute > 59 )); then
  echo "BREW_AUTOUPDATE_MINUTE must be an integer from 0 to 59." >&2
  exit 1
fi

if [[ ! -x "${script_path}" ]]; then
  chmod +x "${script_path}"
fi

mkdir -p "${launch_agents_dir}"

cat > "${plist_path}" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>${label}</string>

  <key>ProgramArguments</key>
  <array>
    <string>${script_path}</string>
  </array>

  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>${execution_hour}</integer>
    <key>Minute</key>
    <integer>${execution_minute}</integer>
  </dict>

  <key>StandardOutPath</key>
  <string>${HOME}/Library/Logs/brewcask-autoupdate/launchd.out.log</string>

  <key>StandardErrorPath</key>
  <string>${HOME}/Library/Logs/brewcask-autoupdate/launchd.err.log</string>
</dict>
</plist>
PLIST

launchctl unload "${plist_path}" >/dev/null 2>&1 || true
launchctl load "${plist_path}"

echo "Installed ${label}"
printf 'Runs daily at %02d:%02d local time.\n' "${execution_hour}" "${execution_minute}"
echo "Log: ${HOME}/Library/Logs/brewcask-autoupdate/brew-autoupdate.log"
