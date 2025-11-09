function __fish_macro_validate_name
    set -l name $argv[1]

    if test -z "$name"
        echo "Function name cannot be empty" >&2
        return 1
    end

    if string match -qr '^\d' "$name"
        echo "Function name cannot start with a number: $name" >&2
        return 1
    end

    if not string match -qr '^[a-zA-Z0-9_-]+$' "$name"
        echo "Function name contains invalid characters: $name" >&2
        echo "Valid characters: letters, numbers, underscore, hyphen" >&2
        return 1
    end

    return 0
end
