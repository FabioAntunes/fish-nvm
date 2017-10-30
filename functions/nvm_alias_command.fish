function nvm_alias_command -d "Create an alias command"
  set -l path (string replace nvm_alias_command.fish '' (status --current-filename))
  set -l aliases (command ls -1 (realpath $path))

  function __nvm_alias_output
    if test -z "$nvm_alias_output"
      echo "/usr/local/bin"
    else
      echo (string replace -r '/$' '' $nvm_alias_output)
    end
  end

  function __create_alias_command
    if test -e "$argv[1]"
      set_color yellow
      echo "Ignored: $argv[1] (already exists)"
      set_color normal
      return 0
    else
      set -l template "__nvm_run \"COMMAND\" \$argv"
      echo '#!/usr/bin/env fish' > $argv[1]
      echo (string replace COMMAND $argv[2] $template) >> $argv[1]
      set_color green
      echo "Success: $argv[2] alias command was created at $argv[1]"
      set_color normal

      return (chmod +x $argv[1])
    end
  end

  set -l outputPath (__nvm_alias_output)
  if test (count $argv) -le 0
    for val in $aliases
      if test $val != "nvm.fish";
        and test $val != "nvm_alias_command.fish";
        and test $val != "nvm_alias_function.fish"

        set -l alias (string replace .fish '' $val)
        __create_alias_command "$outputPath/$alias" $alias
      end
    end
  else
    for arg in $argv
      __create_alias_command "$outputPath/$arg" $arg
    end
  end
end
