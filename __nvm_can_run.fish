function __nvm_can_run
  if type -P $argv[1] > /dev/null 2>&1 or type -P node > /dev/null 2>&1
    return
  else
    return 1
  end
end
