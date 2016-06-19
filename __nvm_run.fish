function __nvm_run
  set count (count $argv)

  if test "$count" -le 0
    echo 'No params'
    return 1
  else  if begin test $argv[1] != "node";  and  test $argv[1] != "npm"; end
    echo 'first argument must be node or npm'
    return 1
  end

  function run_command
    set count (count $argv)

    if test "$count" -ge 2
      set args $argv[2..-1]
    else
      set args ""
    end

    switch $argv[1]
    case npm
      command npm $args
    case node
      command node $args
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
