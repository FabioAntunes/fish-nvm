[![Slack Room][slack-badge]][slack-link]

# Fish-nvm

nvm wrapper for fish-shell.

## Install

With [fisherman]

```
fisher nvm
```

Make sure you have [NVM] installed first.

## Usage

```fish
nvm install 5.0.0
nvm alias default 5.0.0
```

## Please read these Notes:

Sometimes it might happen [NVM] is already sourced, with the wrong version, or not respecting your default version. Check your `~/.profile` or `~/.bashrc` or `~/.bash_profile`. If that's the case, just remove the line that sources [NVM].

Make sure you set a default node version or create a `.nvmrc` file on your working directory.
**fish-nvm** will try to use the `.nvmrc` version specified, if the file exists, if there's no file it will try to use the default version.

If you don't use the `.nvmrc` file or if you don't set a default version, you will have to run `nvm use node-version` every time you open a new terminal and want to use **node** or **npm**

If you have a custom `$NVM_DIR`, please add the following line to your `~/.config/fish/config.fish`, replacing the path accordingly:

```fish
set -gx NVM_DIR /path/to/nvm
```

## Other

Check out also **[fnm]** a pure fish node version manager with automatic version switching.

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
[NVM]: https://github.com/creationix/nvm
[fnm]: https://github.com/fisherman/fnm
