#!/bin/sh

key_to_link="zipball_url"
vendor="beliven-it"
repository_name="laravel-sync"
repository="$vendor/$repository_name"
archive_name="archive"

archive_path_folder="/tmp/$archive_name"
archive_path_zip="$archive_path_folder.zip"

trap _cleanup EXIT

_cleanup() {
	rm -rf $archive_path_zip
	rm -rf $archive_path_folder
}

latest_release=$(curl -s https://api.github.com/repos/$repository/releases/latest | grep "$key_to_link" | cut -d '"' -f 4)

if [ -n "$latest_release" ]; then
	echo "Latest release: $latest_release"
	echo "Download the latest release of $repository ..."

	curl -sL "$latest_release" -o $archive_path_zip
	unzip -q -j $archive_path_zip -d $archive_path_folder
	cp -r $archive_path_folder/$repository_name .
	chmod +x $repository_name
	echo "Done!"
else
	echo "Cannot find a release for $repository"
	exit 1
fi
