#!/usr/bin/env bash
set -euo pipefail

label="com.otakuxavier.brewcask-autoupdate"
plist_path="${HOME}/Library/LaunchAgents/${label}.plist"

launchctl unload "${plist_path}" >/dev/null 2>&1 || true
rm -f "${plist_path}"

echo "Uninstalled ${label}"
