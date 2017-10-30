function nvm_alias_function -d "Create an alias function"
  function __create_alias_function
    if test -e "$argv[1]"
      set_color yellow
      echo "Ignored: $argv[1] (already exists)"
      set_color normal
      return 0
    else
      set -l line1 "function COMMAND -w COMMAND"
      set -l line2 "__nvm_run \"COMMAND\" \$argv"
      echo (string replace -a COMMAND $argv[2] $line1) > $argv[1]
      echo (string replace COMMAND $argv[2] $line2) >> $argv[1]
      echo "end" >> $argv[1]
      return 0
    end
  end

  if test (count $argv) -le 0
    set_color yellow
    echo "Please specify package(s) name(s)"
    set_color normal
    return 1
  else
    for arg in $argv
      __create_alias_function "$fish_function_path[1]/$arg.fish" $argv
    end
  end
end
