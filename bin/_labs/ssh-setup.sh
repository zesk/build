#!/bin/bash
#
# Set up SSH for a user with ID and backup keys in `~/.ssh`
#
# Copyright &copy; 2023, Market Acumen, Inc.
#
# Created 2005/01/06 05:45:46 by kent
#
set -eou pipefail

# IDENTICAL errorArgument 1
errorArgument=2

# Set up SSH for a user with ID and backup keys in `~/.ssh`
#
# Create a key for a user for SSH authentication to other servers.
#
sshSetup() {
	local sshHomePath flagForce servers keyType keyBits

	if [ ! -d "${HOME-}" ]; then
		consoleError "$errorArgument" "HOME is not defined and is required"
	fi
	sshHomePath="$HOME/.ssh/"
	flagForce=0
	servers=
	keyType=ed25519
	keyBits=2048

	while [ $# != 0 ]; do
		case $1 in
		--type)
			shift
			case $1 in
			ed25519 | rsa | dsa)
				keyType=$1
				;;
			*)
				consoleError "$errorArgument" "Key type $1 is not known: ed25519 | rsa | dsa" 1>&2
				return $errorArgument
				;;
			esac
			;;
		--bits)
			shift
			minBits=512
			if [ "$(("$1" + 0))" -lt "$minBits" ]; then
				consoleError "Key bits is too $minBits: $1 -> $(("$1" + 0))" 1>&2
				return $errorArgument
			fi
			;;
		--help)
			usage 0
			;;
		--force)
			flagForce=1
			;;
		*)
			servers="$servers $1"
			;;
		esac
		shift
	done

	if [ ! -d "$sshHomePath" ] && ! mkdir -p .ssh/; then
		consoleError "Can't create $sshHomePath" 1>&2
		return 1
	fi
	chmod 700 "$sshHomePath"
	cd "$sshHomePath"
	user="$(whoami)"
	keyname="$user@$(uname -n)"
	if [ $flagForce = 0 ] && [ -f "$keyname" ]; then
		if [ "$servers" = "" ]; then
			echo "Key $keyname already exists, exiting." 1>&2
			exit $errorArgument
		fi
	else
		echo "Generating $keyname (keyType $keyType $keyBits keyBits)"
		ssh-keygen -f "$keyname" -t "$keyType" -b $keyBits -C "$keyname" -q -N ""
		cp "$keyname" id_"$keyType"
		cp "$keyname".pub id_"$keyType".pub
	fi
	for s in $servers; do
		echo "Uploading key and modifying authorized_keys with $s"
		echo "(Please enter password twice)"
		echo "cd .ssh
		put $keyname.pub
		quit" | sftp "$s" >/dev/null
		echo "cd ~\
		cd .ssh\
		cat *pub > authorized_keys\
		exit" | ssh -T "$s" >/dev/null
	done

}

#
# usage [ exitcode ]
#
usage() {
	echo
	echo "$ME"": Add .ssh key for current user: $(whoami)"
	echo
	echo "$ME" [ --force ] [ server ... ]
	echo
	echo --force Force the program to create a new key if one exists
	echo server Servers to connect to to set up authorization
	echo You will need the password for this server for the current user.
	echo

	exit "$1"
}
