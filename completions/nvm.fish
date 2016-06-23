# NVM (https://github.com/creationix/nvm) completions for Fish shell
# Inspired on (https://github.com/derekstavis/plugin-nvm)

function __nvm_complete_ls_remote
  if not test "$__nvm_ls_remote"
    set -g __nvm_ls_remote (nvm ls-remote | tr -d " " | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
  end

  printf "%s\n" $__nvm_ls_remote
end

function __nvm_complete_ls
  if not test "$__nvm_ls"
    set -g __nvm_ls (nvm ls | tr -d " " | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
  end

  printf "%s\n" $__nvm_ls
end

complete -c nvm -f -n "__fish_seen_subcommand_from install"            -a "(__nvm_complete_ls_remote)"
complete -c nvm -f -n "__fish_seen_subcommand_from uninstall"          -a "(__nvm_complete_ls)"
complete -c nvm -f -n "__fish_seen_subcommand_from use"                -a "(__nvm_complete_ls)"
complete -c nvm -f -n "__fish_seen_subcommand_from which"              -a "(__nvm_complete_ls)"
complete -c nvm -f -n "__fish_seen_subcommand_from reinstall-packages" -a "(__nvm_complete_ls)"
complete -c nvm -f -n "__fish_seen_subcommand_from run"                -a "(__nvm_complete_ls)"


# misc shorter explanations
complete -f -c nvm -n '__fish_use_subcommand' -a 'install' -d ''
