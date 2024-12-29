#!/bin/sh

trap _cleanup EXIT

_cleanup() {
	rm -rf /tmp/archive.zip
	rm -rf /tmp/archive
}

key_to_link="zipball_url"
vendor="beliven-it"
repository_name="laravel-sync"
repository="$vendor/$repository_name"

latest_release=$(curl -s https://api.github.com/repos/$repository/releases/latest | grep "$key_to_link" | cut -d '"' -f 4)

if [ -n "$latest_release" ]; then
	echo "Latest release: $latest_release"
	echo "Download the latest release of $repository ..."

	curl -sL "$latest_release" -o /tmp/archive.zip
	unzip -q -j /tmp/archive.zip -d /tmp/archive
	cp -r /tmp/archive/$repository_name .
	chmod +x $repository_name
	echo "Done!"
else
	echo "Cannot find a release for $repository"
	exit 1
fi
