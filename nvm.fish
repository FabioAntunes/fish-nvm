function nvm
  if not type -q bass
    echo 'Bass is not installed please install it running fisher edc/bass'
    return
  end
  set -q NVM_DIR; or set -gx NVM_DIR ~/.nvm
  set -g nvm_prefix $NVM_DIR
  bass source $nvm_prefix/nvm.sh --no-use ';' nvm $argv
end
