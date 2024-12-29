#!/bin/sh

trap _cleanup EXIT

_cleanup() {
	rm -rf /tmp/archive.zip
	rm -rf /tmp/archive
}

echo "Download the latest relase..."

LATEST_RELEASE=$(curl -s https://api.github.com/repos/beliven-it/laravel-sync/releases/latest | grep "zipball_url" | cut -d '"' -f 4)

echo "Latest release: $LATEST_RELEASE"

if [ -n "$LATEST_RELEASE" ]; then
	curl -sL "$LATEST_RELEASE" -o /tmp/archive.zip
	unzip -q -j /tmp/archive.zip -d /tmp/archive
	cp -r /tmp/archive/laravel-sync .
	chmod +x laravel-sync
	echo "Done!"
else
	echo "Cannot find the latest release"
	exit 1
fi
