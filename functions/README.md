# Fish Functions Directory

This directory contains all Fish shell function implementations for fish-macro.

## File Organization

### Main Entry Point
- `macro.fish` - Main router function that handles subcommand dispatch (add, edit, list,
  remove, promote)

### Private Utilities
All utility functions use the `__fish_macro_` prefix to indicate they're private helpers:

- `__fish_macro_conflict.fish` - Conflict detection (checks if name exists as
  command/function/macro)
- `__fish_macro_validate_name.fish` - Function name validation
- `__fish_macro_error.fish` - Error messaging helpers

### Installation
During installation, all files in this directory will be copied to
`~/.config/fish/functions/` to make them available in Fish shell.

## Design Decisions Referenced
- **D004**: Conflict handling - check for existing commands/functions before creating
- **D005**: No name length restrictions - allow any valid Fish function name
- **D008**: Installation via install.fish script
