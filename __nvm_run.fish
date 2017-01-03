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
      eval (type -fP $argv[1]) $args
    else
      echo (set_color -o)"Fish nvm:"(set_color normal) "'$argv[1]' is currently not installed, try running npm i -g $argv[1]"
      return 1
    end
  end

  function run_default
    nvm use default
    if __nvm_can_run $argv[1]
      run_command $argv
    end
  end

  if not __nvm_can_run $argv[1]
    if test -f .nvmrc; and nvm use > /dev/null 2>&1

      if __nvm_can_run $argv[1]
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
