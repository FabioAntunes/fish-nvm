# fish-nvm

nvm wrapper for fish-shell.

## Install

With [fisher](https://github.com/jorgebucaran/fisher)

```fish
fisher add FabioAntunes/fish-nvm
```

With [oh-my-fish]
```fish
omf install https://github.com/FabioAntunes/fish-nvm
omf install https://github.com/edc/bass
```

Make sure you have [NVM] installed first.

**fish-nvm** depends on [bass] 

## Usage

```fish
nvm install 6.11.1
nvm alias default 6.11.1
```

## How it works

The way this plugin works is delaying sourcing nvm, until we really need it. That way we don't have those annoying 1/2 seconds of delay every time we open a new terminal window/tab.

By delaying the sourcing of nvm **YOUR NODE BINARIES WON'T BE LOADED** until you source nvm or run one of the following alias. If you want to source nvm every single time you open a terminal just use [bass](https://github.com/edc/bass#nvm)

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
touch /usr/local/bin/node
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

To create additional ones after running the first time without args, just pass them as arguments separated by spaces

```fish
nvm_alias_command eslint prettier
```

The default output path is `/urs/local/bin`, if you get an error message due to permissions, try running with sudo permissions:

```fish
sudo fish nvm_alias_command eslint prettier
```

To change the default output folder just set a global variable:

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


Also, if you have a custom installation path but still set `$NVM_DIR` to default path. For example this could happen if you install [NVM] using [brew], which would install nvm into: `/usr/local/Cellar/nvm/%nvm_version%/nvm.sh`

If that is the case you add the following line to your `~/.config/fish/config.fish`, replacing the path accordingly:

```fish
set -gx nvm_prefix /path/to/nvm
```


**NOTE:**

**DO NOT** use a trailing slash in `NVM_DIR` variable.
Adding it will cause error: `nvm is not compatible with the npm config "prefix" option`

## Other

Check out also **[fnm]** a pure fish node version manager with automatic version switching.

[NVM]: https://github.com/creationix/nvm
[fnm]: https://github.com/fisherman/fnm
[brew]: https://brew.sh/
[oh-my-fish]: https://github.com/oh-my-fish/oh-my-fish
[bass]: https://github.com/edc/bass

### License

fish-nvm is [MIT licensed](./LICENSE.md).
