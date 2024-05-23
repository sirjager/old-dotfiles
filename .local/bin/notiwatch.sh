#!/bin/bash

fix_command() {
	local command="$1"
  # gets command
	command=$(echo "$line" | awk -F ':' '{print $3;}' | awk '{print substr($0, 1, length($0)-1)}')
	# Replace "&quot;" with '"'
	# shellcheck disable=2001
	command=$(echo "$command" | sed 's/&quot;/"/g')
	# Remove leading and trailing spaces
	command=$(echo "$command" | awk '{$1=$1};1')
	echo "$command"
}

# Listen for notifications using dbus-monitor
dbus-monitor --session "interface='org.freedesktop.Notifications'" |
	while read -r line; do
		if [[ "$line" =~ "violet:commands" ]]; then
			command=$(fix_command "$line")
			eval "$command"
		fi
	done
