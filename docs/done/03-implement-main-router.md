# T003: Implement Main macro.fish Router

**Status**: Completed
**Date**: 2025-11-05
**Priority**: High
**Dependencies**: T001

## Goal
Create main 'macro' function that routes to subcommands and handles help text

## What Was Done

1. **Created `macro.fish` with main routing function**
   - Parses first argument as subcommand
   - Routes to appropriate subcommand function using switch statement
   - Handles: add, edit, list, remove, promote

2. **Implemented help text via `__fish_macro_help`**
   - Displays on `macro` (no args) or `macro --help`
   - Shows usage, command list with descriptions
   - Clean, readable format similar to modern CLI tools

3. **Implemented error handling for unknown commands**
   - Uses `__fish_macro_error` for consistent error messaging
   - Shows helpful hint to run `macro --help`
   - Returns proper error status code

4. **Created stub functions for all subcommands**
   - `__fish_macro_add` - prints "Not implemented yet"
   - `__fish_macro_edit` - prints "Not implemented yet"
   - `__fish_macro_list` - prints "Not implemented yet"
   - `__fish_macro_remove` - prints "Not implemented yet"
   - `__fish_macro_promote` - prints "Not implemented yet"

## Files Created
- `lib/fish-macro/functions/macro.fish`

## Testing Performed
- ✓ `macro` (no args) shows help text
- ✓ `macro --help` shows help text
- ✓ `macro add` calls stub function
- ✓ `macro invalid` shows error with helpful hint

## Next Steps
Ready to proceed with T004: Implement macro add command
