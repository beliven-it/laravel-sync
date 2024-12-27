# Laravel Sync

<br />

A bash script used to sync the Laravel project contents between different environments.

## 💫 Usecase

The main scope of the script is used to sync the database and assets between different environments.

For example, you can have a [Statamic](https://statamic.com/) project in production costantly updated with new content by the client.
You need to sync the contents of your local environment to test the new features with a real snapshot of the production environment.

With this script you can now sync the database and assets between the environments 🌟🌟🌟!!!

> [!WARNING]
> ⚠️ ⚠️ ⚠️
>
> This script provide a `push` command to a remote environment.
> Make sure to have a backup of the remote environment before using the `push` command.
>
> ⚠️ ⚠️ ⚠️

<br /><br />

## 🔗 Requirements

The script requires the following tools:

- 🐳 [Docker](https://www.docker.com/) - Used if you use sail layer.
- 🌐 [SSH](https://www.openssh.com/) - Used to connect to the remote server.

<br /><br />

## ⚙️ Installation

You can install the script in your laravel project using the following command:

```bash
curl https://raw.githubusercontent.com/beliven-it/laravel-sync/main/install.sh | bash
```

This command download the latest release of the script and make it executable.

### Global installation

You can also move the file to a directory that is in your `$PATH`, such as `/usr/local/bin`.

```bash
sudo mv laravel-sync /usr/local/bin
```

This allow you to run the script from any directory.

```bash
laravel-sync -h
```

> [!NOTE]
>
> Make sure to use a tagged version of the script to avoid any issue.

<br /><br />

## 🛠 Configuration

The script uses the `.env` file as configuration.

Make sure to add the following variable to the `.env` file:

```bash
echo "SYNC_ENVIRONMENT_ALLOWED='staging production'" >> .env
```

If you have a different environment, you can add it to the `SYNC_ENVIRONMENT_ALLOWED` variable.

```bash
# For example if you have staging, uat and production environments
echo "SYNC_ENVIRONMENT_ALLOWED='staging uat production'" >> .env
```

At the first run:

```bash

./laravel-sync config

```

This command create inside the `.env` the env needed to use the script. An example of the `.env` file is:

```bash
SYNC_ENVIRONMENT_ALLOWED="staging production"

# Folders to download / upload
SYNC_ENVIRONMENT_ASSETS="storage/statamic/glide/containers content"

# Local environment
# Database environment
SYNC_ENVIRONMENT_LOCAL_DB_HOST="${DB_HOST}"
SYNC_ENVIRONMENT_LOCAL_DB_PORT="${DB_PORT}"
SYNC_ENVIRONMENT_LOCAL_DB_USERNAME="${DB_USERNAME}"
SYNC_ENVIRONMENT_LOCAL_DB_PASSWORD="${DB_PASSWORD}"
SYNC_ENVIRONMENT_LOCAL_DB_DATABASE="${DB_DATABASE}"
SYNC_ENVIRONMENT_LOCAL_DB_CONNECTION="${DB_CONNECTION}"

# Host environment for local is not needed

# Staging environment
# # Database environment
SYNC_ENVIRONMENT_STAGING_DB_HOSTNAME=
SYNC_ENVIRONMENT_STAGING_DB_PORT=
SYNC_ENVIRONMENT_STAGING_DB_PASSWORD=
SYNC_ENVIRONMENT_STAGING_DB_USERNAME=
SYNC_ENVIRONMENT_STAGING_DB_DATABASE=
SYNC_ENVIRONMENT_STAGING_DB_CONNECTION=

# Host environment
SYNC_ENVIRONMENT_STAGING_HOST_USER=
SYNC_ENVIRONMENT_STAGING_HOST_HOSTNAME=
SYNC_ENVIRONMENT_STAGING_HOST_PORT=
SYNC_ENVIRONMENT_STAGING_HOST_BASE_PATH=

# Production environment
# Database environment
SYNC_ENVIRONMENT_PRODUCTION_DB_HOST=
SYNC_ENVIRONMENT_PRODUCTION_DB_PORT=
SYNC_ENVIRONMENT_PRODUCTION_DB_USERNAME=
SYNC_ENVIRONMENT_PRODUCTION_DB_PASSWORD=
SYNC_ENVIRONMENT_PRODUCTION_DB_DATABASE=
SYNC_ENVIRONMENT_PRODUCTION_DB_CONNECTION=

# Host environment
SYNC_ENVIRONMENT_PRODUCTION_HOST_HOSTNAME=
SYNC_ENVIRONMENT_PRODUCTION_HOST_PORT=
SYNC_ENVIRONMENT_PRODUCTION_HOST_USER=
SYNC_ENVIRONMENT_PRODUCTION_HOST_BASE_PATH=
```

<br /><br />

## 💻 Usage

The script require one of following actions:

- **pull** - Pull the database and assets from the remote environment.
- **push** - Push the database and assets to the remote environment.
- **config** - Setup the `.env` file.

When you use the `pull` or `push` actions, you need to specify the environment. For example:

```bash

./laravel-sync pull staging
```

or

```bash

./laravel-sync push staging
```

The following options are also available

```bash
-a, --ignore-database  Ignore database sync
-d, --ignore-assets    Ignore assets sync
-k, --use-docker       Use docker for database sync
-s, --sendbox          Show only the commands without executing
-y, --yes              Skip confirmation
-c, --no-cleanup       Skip cleanup
-h, --help             Show this help
```

Run the help command to see the list of available examples:

```bash

./laravel-sync -h
```

<br /><br />

## 💬 FAQs

### How to pull the remote environment to a local environment that use Sail?

You can use the `--use-docker` option to use Docker to pull the database. For example:

```bash
./laravel-sync pull staging --use-docker

# ... or using the short flag version

./laravel-sync pull staging -k
```

### How can avoid to run SSH command with plain text password?

You can edit the `.env` file and add set the: `SYNC_ENVIRONMENT_<environment_choosed>_DB_PASSWORD` to empty.

When you launch the commands, the script will ask you to insert the password.

<br /><br />

## 👨‍💻 Development

Clone the repository and start to develop the script.

Make sure to run use `shellcheck` to lint the script.

```bash
shellcheck laravel-sync
```

<br /><br />

## 📝 Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information on what has changed recently.

<br /><br />

## 📝 License

The script is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
