[![Slack Room][slack-badge]][slack-link]

# fish-nvm

nvm wrapper for fish-shell.

## Install

With [fisherman]

```fish
fisher nvm
```

Make sure you have [NVM] installed first.

## Usage

```fish
nvm install 6.11.1
nvm alias default 6.11.1
```

## How it works

The way this plugin works is delaying sourcing nvm, until we really need it. That way we don't have those annoying 1/2 seconds of delay every time we open a new terminal window/tab.

![fish nvm example](/../readme-images/nvm.gif?raw=true)

There are a couple of alias already created. They will source NVM whenever you call them:
* npm
* yarn
* node
* nvm
* npx

What this means is that if you depend on other node global packages, let's say `gulp`, if you try to run `gulp` in a fresh window/tab you will get something like `Command unknown`.
One way to solve this is running `nvm use default`, or any of the alias before using the command `gulp`.

Since that's far from great, especially if you depend a lot on these global packages you can easily create your own function inside `~/.config/fish/functions`, so for `gulp` would be something like this:

```fish
function gulp -d "gulp task manager" -w gulp
  __nvm_run "gulp" $argv
end
```

To simplify this process there's an helper function on `fish-nvm` just run `nvm_alias_function name`, you can pass multiple packages names, separated by spaces:

```fish
nvm_alias_function gulp webpack grunt
```

![fish nvm example](/../readme-images/nvm_alias_function.gif?raw=true)

This will create 3 functions on your functions folder `~/.config/fish/functions`

Another common scenario is if you need to have the binary of the node or package available. For example if you are vim user, some plugins need access to the node binary.
Since we only source nvm when we use one of the alias, you will probably get an error saying that node isn't available.

For example to create a binary for `node` we could create a file under `/usr/local/bin`

```fish
touch `/usr/local/bin/node`
```

Open that file on your editor and paste the following:

```fish
#! /usr/bin/env fish

__nvm_run "node" $argv
```

Make that file executable:

```fish
chmod +x /usr/local/bin/node
```

Test it

```fish
which node
```

To simplify this process there's another helper function `nvm_alias_command`

If you run `nvm_alias_command` without any arguments it will create the alias binaries provided by default by `fish-nvm`: `npm`, `node`, `npx`, `yarn`

![fish nvm example](/../readme-images/nvm_alias_command.gif?raw=true)

To create additional ones just pass them as arguments separated by spaces

```fish
nvm_alias_command eslint prettier
```

The default output path is `/urs/local/bin`, to change the output folder just set a global variable:

```fish
set -g nvm_alias_output /other/path
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

**NOTE:** DO NOT use a trailing slash in `NVM_DIR` variable.
Adding it will cause error: `nvm is not compatible with the npm config "prefix" option`

## Other

Check out also **[fnm]** a pure fish node version manager with automatic version switching.

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
[NVM]: https://github.com/creationix/nvm
[fnm]: https://github.com/fisherman/fnm
