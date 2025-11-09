function __fish_macro_conflict
    set -l name $argv[1]

    if test -z "$name"
        return 1
    end

    set -l type_output (type -t $name 2>/dev/null)

    if test -n "$type_output"
        return 0
    end

    return 1
end
