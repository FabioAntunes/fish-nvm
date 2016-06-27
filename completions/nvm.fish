# NVM (https://github.com/creationix/nvm) completions for Fish shell
# Inspired on (https://github.com/derekstavis/plugin-nvm)

function __nvm_complete_ls_remote
  if not test "$__nvm_ls_remote"
    set -g __nvm_ls_remote (nvm ls-remote | grep -Po '(?:iojs-)?v[0-9]\.[0-9]\.[0-9]*')
  end

  printf "%s\n" $__nvm_ls_remote
end

function __nvm_complete_ls
  if not test "$__nvm_ls"
    set -g __nvm_ls (nvm ls | grep -Po '[[:space:]].\K(v[0-9]\.[0-9]\.[0-9]*)')
  end

  printf "%s\n" $__nvm_ls
end

#Install
complete -f -c nvm -n '__fish_use_subcommand' -a 'install' -d 'Download and install a <version>. Uses .nvmrc if available'
complete -f -c nvm -n "__fish_seen_subcommand_from install" -a "(__nvm_complete_ls_remote)"
complete -f -c nvm -n "__fish_seen_subcommand_from install" -l reinstall-packages-from= -d 'When installing, reinstall packages installed in <node|iojs|node version number>'
complete -f -c nvm -n "__fish_seen_subcommand_from install" -s s -d 'From source'

#Use
complete -f -c nvm -n '__fish_use_subcommand' -a 'use' -d 'Modify PATH to use <version>. Uses .nvmrc if available'
complete -f -c nvm -n "__fish_seen_subcommand_from use" -a "(__nvm_complete_ls)"
complete -f -c nvm -n "__fish_seen_subcommand_from use" -l silent

#Exec
complete -f -c nvm -n '__fish_use_subcommand' -a 'exec' -d 'Run <command> on <version>. Uses .nvmrc if available'
complete -f -c nvm -n "__fish_seen_subcommand_from exec" -a "(__nvm_complete_ls)"
complete -f -c nvm -n "__fish_seen_subcommand_from exec" -l silent

#Run
complete -f -c nvm -n '__fish_use_subcommand' -a 'run' -d 'Run <command> on <version>. Uses .nvmrc if available'
complete -f -c nvm -n "__fish_seen_subcommand_from run" -a "(__nvm_complete_ls)"
complete -f -c nvm -n "__fish_seen_subcommand_from run" -l silent


#Uninstall
complete -f -c nvm -n '__fish_use_subcommand' -a 'uninstall' -d 'Uninstall a version'
complete -f -c nvm -n "__fish_seen_subcommand_from uninstall" -a "(__nvm_complete_ls)"

#Which
complete -f -c nvm -n '__fish_use_subcommand' -a 'which' -d 'Display path to installed node version. Uses .nvmrc if available'
complete -f -c nvm -n "__fish_seen_subcommand_from which" -a "(__nvm_complete_ls)"

#Reinstall-Packages
complete -f -c nvm -n '__fish_use_subcommand' -a 'reinstall-packages' -d 'Reinstall global `npm` packages contained in <version> to current version'
complete -f -c nvm -n "__fish_seen_subcommand_from reinstall-packages" -a "(__nvm_complete_ls)"

#Completions
complete -f -c nvm -n '__fish_use_subcommand' -a 'current' -d 'Display currently activated version'
complete -f -c nvm -n '__fish_use_subcommand' -a 'ls' -d 'List installed versions'
complete -f -c nvm -n '__fish_use_subcommand' -a 'ls-remote' -d 'List remote versions available for install'
complete -f -c nvm -n '__fish_use_subcommand' -a 'version' -d 'Resolve the given description to a single local <version>'
complete -f -c nvm -n '__fish_use_subcommand' -a 'version-remote' -d 'Resolve the given description to a single remote <version>'
complete -f -c nvm -n '__fish_use_subcommand' -a 'deactivate' -d 'Undo effects of `nvm` on current shell'
complete -f -c nvm -n '__fish_use_subcommand' -a 'alias' -d 'Show all aliases beginning with <pattern> or set an alias named <name> pointing to <version>'
complete -f -c nvm -n '__fish_use_subcommand' -a 'unalias' -d 'Deletes the alias named <name>'
complete -f -c nvm -n '__fish_use_subcommand' -a 'unload' -d 'Unload `nvm` from shell'
