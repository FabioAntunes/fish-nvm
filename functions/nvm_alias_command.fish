function nvm_alias_command -d "Create an alias command"
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
      printf "#!/usr/bin/env fish\n%s\n" (string replace COMMAND $argv[2] $template) > $argv[1]
      if test $status -eq 0
        printf "\U2705   %s alias command was created at %s\n" $argv[2] $argv[1]
        return (chmod +x $argv[1])
      else
        printf "\U274C failed creating  %s alias command at %s\n" $argv[2] $argv[1]
        printf "Probably a permissions problem, try running sudo fish, and then nvm_alias_command\n"
      end
    end
  end

  set -l outputPath (__nvm_alias_output)
  mkdir -p $outputPath

  if test $status -ge 1
    printf "\U274C failed creating dir $outputPath."
    printf "Probably a permissions problem, try running sudo fish, and then nvm_alias_command\n"
    exit 1
  end

  if test (count $argv) -le 0
    set -l aliases node npm npx yarn

    for alias in $aliases
        __create_alias_command "$outputPath/$alias" $alias
    end
  else
    for arg in $argv
      __create_alias_command "$outputPath/$arg" $arg
    end
  end
end
