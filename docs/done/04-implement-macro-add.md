# T004: Implement macro add <name>

**Status**: Completed
**Date**: 2025-11-05
**Priority**: High
**Dependencies**: T002, T003

## Goal
Implement the core `macro add` command to create functions from history

## What Was Done

1. **Implemented argument validation**
   - Checks that name argument is provided
   - Uses `__fish_macro_validate_name` for name validation
   - Returns clear error messages for invalid input

2. **Implemented conflict detection (per D004)**
   - Uses `__fish_macro_conflict` to detect existing commands/functions
   - Errors and aborts if conflict with built-in command or function
   - Warns but continues if overwriting existing macro

3. **Implemented history fetching (per D001, D006)**
   - Fetches last 50 commands using `history --max 50`
   - Shows raw, unfiltered history
   - Preserves multi-line commands as-is

4. **Implemented editor integration**
   - Creates temp file with history content
   - Uses `$EDITOR` environment variable (falls back to `vi`)
   - Opens editor and waits for user to edit
   - Handles editor errors gracefully

5. **Implemented content parsing (per D002)**
   - Reads edited temp file
   - Filters out empty lines and comments
   - Aborts if no commands remain (empty function)

6. **Implemented function file generation**
   - Creates proper Fish function format
   - Wraps commands in `function <name>...end`
   - Indents commands for readability

7. **Implemented file saving**
   - Ensures `~/.config/fish/functions/` directory exists
   - Saves to `~/.config/fish/functions/<name>.fish`
   - Cleans up temp file
   - Shows success message with file path

## Files Modified
- `lib/fish-macro/functions/macro.fish` - Replaced `__fish_macro_add` stub with full
  implementation

## Testing Performed
- ✓ No argument → error with usage message
- ✓ Invalid name (starts with number) → validation error
- ✓ Conflict with existing command (ls) → conflict error
- ✓ Function generation logic → correct Fish function format

**Note**: Full end-to-end interactive testing requires real Fish shell environment (not
testable in sandbox)

## Design Decisions Applied
- **D001**: Raw history display - shows unfiltered history
- **D002**: Abort on empty function - validates content after editing
- **D004**: Conflict handling - checks before creating
- **D006**: Multi-line commands preserved - no transformation

## Next Steps
Ready to proceed with T005: Implement macro edit command
