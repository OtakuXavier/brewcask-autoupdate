#!/usr/bin/env bash
set -euo pipefail

label="com.otakuxavier.brewcask-autoupdate"
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script_path="${repo_dir}/brew-autoupdate.sh"
launch_agents_dir="${HOME}/Library/LaunchAgents"
plist_path="${launch_agents_dir}/${label}.plist"

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
    <integer>8</integer>
    <key>Minute</key>
    <integer>0</integer>
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
echo "Runs daily at 8:00 AM local time."
echo "Log: ${HOME}/Library/Logs/brewcask-autoupdate/brew-autoupdate.log"
