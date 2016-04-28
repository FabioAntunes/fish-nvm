[![Slack Room][slack-badge]][slack-link]

# Fish-nvm

nvm wrapper for Fish Shell

## Install

With [fisherman]

```
fisher nvm
```

Make sure you have [nvm] installed first

## Usage

```fish
nvm install 5.0.0
nvm alias default 5.0.0
```

**Note:**
Make sure you set a default node version or create a .nvmrc file on your working directory.
**fish-nvm** will try to use the .nvmrc version specified if the file exists, if there's no file it will try to use the default version.

If you don't use the .nvmrc file or you don't set a a default version you will have to run `nvm use node-version` every time you open a new terminal and want to use **node** or **npm**

If you have a custom $NVM_DIR, please add the following line to your ~/.config/fish/config.fish, replacing the path accordingly:

```bash
set -gx NVM_DIR /path/to/nvm
```

### PS
Checkout [fin] a pure fish node version manager

This plugin was inspired on [omf-nvm]

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
[nvm]: https://github.com/creationix/nvm
[fin]: https://github.com/fisherman/fin
[omf-nvm]: https://github.com/derekstavis/plugin-nvm
