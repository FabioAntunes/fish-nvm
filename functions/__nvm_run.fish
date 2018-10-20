function __nvm_run
  set count (count $argv)

  if test "$count" -le 0
    echo 'No params'
    return 1
  end

  function run_command
    set count (count $argv)
    if test "$count" -ge 2
      set args $argv[2..-1]
    else
      set args ""
    end

    if type -fqP $argv[1]
      # https://stackoverflow.com/questions/45237675/proxying-arguments-from-one-function-to-a-command/45238056#45238056
      eval (string escape -- (type -fP $argv[1]) $args)
    else
      echo (set_color -o)"Fish nvm:"(set_color normal) "'$argv[1]' is currently not installed, try running npm i -g $argv[1]"
      return 1
    end
  end

  function can_run_command
    if type -P $argv[1] > /dev/null 2>&1; or type -P node > /dev/null 2>&1
      return
    else
      return 1
    end
  end

  function run_default
    nvm use default > /dev/null
    set -gx NVM_HAS_RUN 1
    if can_run_command $argv[1]
      run_command $argv
    end
  end

  if not test -n "$NVM_HAS_RUN"
    if test -f .nvmrc; and nvm use > /dev/null 2>&1
      if can_run_command $argv[1]
        set -gx NVM_HAS_RUN 1
        run_command $argv
      else
        run_default $argv
      end
    else
      run_default $argv
    end
  else
    run_command $argv
  end
end
