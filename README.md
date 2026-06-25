# brewcask-autoupdate

Runs the requested Homebrew command daily at 8:00 AM local time:

```sh
brew upgrade && brew update
```

## Install

```sh
chmod +x brew-autoupdate.sh install-launch-agent.sh uninstall-launch-agent.sh
./install-launch-agent.sh
```

The installer writes this LaunchAgent:

```text
~/Library/LaunchAgents/com.otakuxavier.brewcask-autoupdate.plist
```

## Run Manually

```sh
./brew-autoupdate.sh
```

## Logs

```text
~/Library/Logs/brewcask-autoupdate/brew-autoupdate.log
~/Library/Logs/brewcask-autoupdate/launchd.out.log
~/Library/Logs/brewcask-autoupdate/launchd.err.log
```

## Uninstall

```sh
./uninstall-launch-agent.sh
```
