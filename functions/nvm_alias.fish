function nvm_alias
  set -l outputPath (__nvm_alias_output)
  set -l path (string replace nvm_alias.fish '' (status --current-filename))
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
      return (chmod +x $argv[1])
    end
  end

  if test (count $argv) -le 0
    for val in $aliases
      if test "nvm.fish" != $val; and test "nvm_alias.fish" != $val
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
