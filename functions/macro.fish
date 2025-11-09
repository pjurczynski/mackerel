function macro
    set -l subcommand $argv[1]

    switch "$subcommand"
        case "" --help -h help
            __fish_macro_help
        case add
            __fish_macro_add $argv[2..]
        case edit
            __fish_macro_edit $argv[2..]
        case list
            __fish_macro_list $argv[2..]
        case remove
            __fish_macro_remove $argv[2..]
        case promote
            __fish_macro_promote $argv[2..]
        case '*'
            __fish_macro_error "unknown command: $subcommand"
            echo "Run 'macro --help' for usage information" >&2
            return 1
    end
end

function __fish_macro_help
    echo "macro - Quick function creator for Fish shell"
    echo ""
    echo "Usage:"
    echo "  macro <command> [arguments]"
    echo ""
    echo "Commands:"
    echo "  add <name>              Create new function from history"
    echo "  edit <name>             Edit existing macro"
    echo "  list                    Show all defined macros"
    echo "  remove <name>           Delete a macro"
    echo "  promote <name> <new>    Rename to more descriptive name"
    echo ""
    echo "  --help, -h, help        Show this help message"
end

function __fish_macro_add
    set -l name $argv[1]

    if test -z "$name"
        __fish_macro_error "name argument required"
        echo "Usage: macro add <name>" >&2
        return 1
    end

    if not __fish_macro_validate_name "$name"
        return 1
    end

    if __fish_macro_conflict "$name"
        __fish_macro_error "name conflicts with existing command or function: $name"
        return 1
    end

    set -l func_path "$HOME/.config/fish/functions/$name.fish"
    if test -f "$func_path"
        echo "Warning: macro '$name' already exists and will be overwritten" >&2
    end

    set -l temp_file (mktemp /tmp/fish-macro-XXXXXX.fish)
    if test $status -ne 0
        __fish_macro_error "failed to create temporary file"
        return 1
    end

    history --max 50 >$temp_file

    set -l editor_cmd "$EDITOR"
    if test -z "$editor_cmd"
        set editor_cmd vi
    end

    eval $editor_cmd $temp_file
    if test $status -ne 0
        rm -f $temp_file
        __fish_macro_error "editor exited with error"
        return 1
    end

    set -l lines
    for line in (cat $temp_file)
        set -l trimmed (string trim $line)
        if test -n "$trimmed"; and not string match -q '#*' $trimmed
            set -a lines $line
        end
    end

    if test (count $lines) -eq 0
        rm -f $temp_file
        __fish_macro_error "no commands in edited content (function would be empty)"
        return 1
    end

    mkdir -p "$HOME/.config/fish/functions"

    echo "# fish-macro" >$func_path
    echo "function $name" >>$func_path
    for line in $lines
        echo "    $line" >>$func_path
    end
    echo "end" >>$func_path

    rm -f $temp_file

    # Load the new function into current session
    source $func_path

    echo "Created macro: $name"
    echo "Function saved to: $func_path"
    return 0
end

function __fish_macro_edit
    set -l name $argv[1]

    if test -z "$name"
        __fish_macro_error "name argument required"
        echo "Usage: macro edit <name>" >&2
        return 1
    end

    set -l func_path "$HOME/.config/fish/functions/$name.fish"
    if not test -f "$func_path"
        __fish_macro_error "macro does not exist: $name"
        echo "File not found: $func_path" >&2
        return 1
    end

    set -l editor_cmd "$EDITOR"
    if test -z "$editor_cmd"
        set editor_cmd vi
    end

    eval $editor_cmd $func_path
    if test $status -ne 0
        __fish_macro_error "editor exited with error"
        return 1
    end

    # Reload the edited function
    source $func_path

    echo "Edited macro: $name"
    return 0
end

function __fish_macro_list
    set -l funcs_dir "$HOME/.config/fish/functions"

    if not test -d "$funcs_dir"
        echo "No macros found (directory does not exist: $funcs_dir)"
        return 0
    end

    set -l count 0

    for file in $funcs_dir/*.fish
        if not test -f "$file"
            continue
        end

        # Only show functions created by fish-macro (marked with # fish-macro)
        if not grep -q "^# fish-macro" $file 2>/dev/null
            continue
        end

        set -l func_name (basename $file .fish)
        echo "  $func_name"
        set count (math $count + 1)
    end

    if test $count -eq 0
        echo "No macros found. Create one with: macro add <name>"
    else
        echo ""
        echo "Total: $count macros"
    end

    return 0
end

function __fish_macro_remove
    set -l name $argv[1]

    if test -z "$name"
        __fish_macro_error "name argument required"
        echo "Usage: macro remove <name>" >&2
        return 1
    end

    set -l func_path "$HOME/.config/fish/functions/$name.fish"
    if not test -f "$func_path"
        __fish_macro_error "macro does not exist: $name"
        return 1
    end

    read -l -P "Remove macro '$name'? [y/N] " confirm
    if test "$confirm" != "y" -a "$confirm" != "Y"
        echo "Cancelled"
        return 1
    end

    rm -f "$func_path"
    if test $status -eq 0
        # Erase the function from current session
        functions -e $name
        echo "Removed macro: $name"
        return 0
    else
        __fish_macro_error "failed to remove file: $func_path"
        return 1
    end
end

function __fish_macro_promote
    set -l old_name $argv[1]
    set -l new_name $argv[2]

    if test -z "$old_name" -o -z "$new_name"
        __fish_macro_error "requires two arguments"
        echo "Usage: macro promote <old_name> <new_name>" >&2
        return 1
    end

    if not __fish_macro_validate_name "$new_name"
        return 1
    end

    set -l old_path "$HOME/.config/fish/functions/$old_name.fish"
    if not test -f "$old_path"
        __fish_macro_error "macro does not exist: $old_name"
        return 1
    end

    if __fish_macro_conflict "$new_name"
        __fish_macro_error "new name conflicts with existing command or function: $new_name"
        return 1
    end

    set -l new_path "$HOME/.config/fish/functions/$new_name.fish"
    if test -f "$new_path"
        __fish_macro_error "macro already exists with new name: $new_name"
        return 1
    end

    sed "s/function $old_name/function $new_name/" $old_path >$new_path
    if test $status -ne 0
        rm -f $new_path
        __fish_macro_error "failed to create new function file"
        return 1
    end

    rm -f $old_path

    # Update functions in current session
    functions -e $old_name
    source $new_path

    echo "Promoted macro: $old_name → $new_name"
    return 0
end
