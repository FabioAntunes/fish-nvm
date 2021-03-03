function __nvm_run
  set count (count $argv)

  if test "$count" -le 0
    echo 'No params'
    return 1
  end

  if test (uname -s) = 'Darwin'; and string match -q "*versions/node/*/bin" $PATH
    set -l nvm_node_path (string match "*versions/node/*/bin" $PATH)
    set -l nvm_index (contains -i -- $nvm_node_path $PATH)
    if test $nvm_index -gt 1
      set -gx PATH $nvm_node_path (string match -v $nvm_node_path $PATH)
    end
  end

  function run_command
    set stack (status stack-trace | grep called | cut -d " " -f 7)
    set count (count $argv)

    if type -fq $argv[1]; and test "$stack[1]" != (which $argv[1])
      set count (count $argv)
      if test "$count" -ge 2
        set args $argv[2..-1]

        # https://stackoverflow.com/questions/45237675/proxying-arguments-from-one-function-to-a-command/45238056#45238056
        eval (string escape -- (type -fP $argv[1]) $args)
      else
        eval (string escape -- (type -fP $argv[1]))
      end
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
    if test -f .nvmrc;
      set nvm_output (nvm use)
      set nvm_status $status
      if test $nvm_status -gt 0
        echo $nvm_output
      end
      if test $nvm_status -eq 0; and can_run_command $argv[1]
        set -gx NVM_HAS_RUN 1
        run_command $argv
      end
    else
      run_default $argv
    end
  else
    run_command $argv
  end
end
