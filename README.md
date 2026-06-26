# brewcask-autoupdate

Shell script for daily brewcask update task.

Runs the requested Homebrew command daily at 8:00 AM local time:

```sh
brew upgrade && brew update
```

## Install

```sh
chmod +x brew-autoupdate.sh install-launch-agent.sh uninstall-launch-agent.sh
./install-launch-agent.sh
```

The execution time is configurable with variables:

```sh
BREW_AUTOUPDATE_HOUR=8 BREW_AUTOUPDATE_MINUTE=0 ./install-launch-agent.sh
```

Use 24-hour time. For example, 9:30 PM is:

```sh
BREW_AUTOUPDATE_HOUR=21 BREW_AUTOUPDATE_MINUTE=30 ./install-launch-agent.sh
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
