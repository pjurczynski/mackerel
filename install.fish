#!/usr/bin/env fish

# fish-macro installation script
# Copies function files to ~/.config/fish/functions/

set -l script_dir (dirname (status -f))
set -l funcs_dir "$HOME/.config/fish/functions"

echo "fish-macro installer"
echo "===================="
echo ""

# Check if functions directory exists
if not test -d "$funcs_dir"
    echo "Creating functions directory: $funcs_dir"
    mkdir -p "$funcs_dir"
    if test $status -ne 0
        echo "ERROR: Failed to create directory: $funcs_dir" >&2
        exit 1
    end
end

# Count files to install
set -l files_to_install (count $script_dir/functions/*.fish)
if test $files_to_install -eq 0
    echo "ERROR: No function files found in $script_dir/functions/" >&2
    exit 1
end

echo "Installing $files_to_install function files..."
echo ""

# Copy each function file
set -l installed 0
set -l failed 0

for file in $script_dir/functions/*.fish
    set -l basename (basename $file)
    set -l dest "$funcs_dir/$basename"

    echo -n "  $basename ... "

    cp $file $dest
    if test $status -eq 0
        echo "OK"
        set installed (math $installed + 1)
    else
        echo "FAILED" >&2
        set failed (math $failed + 1)
    end
end

echo ""
echo "===================="

if test $failed -gt 0
    echo "Installation completed with errors"
    echo "  Installed: $installed"
    echo "  Failed: $failed"
    exit 1
else
    echo "Installation successful!"
    echo "  Installed: $installed files"
    echo ""
    echo "Try it out:"
    echo "  macro --help"
    echo ""
    echo "Create your first macro:"
    echo "  macro add g"
    exit 0
end
