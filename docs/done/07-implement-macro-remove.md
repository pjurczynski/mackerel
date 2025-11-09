# T007: Implement macro remove <name>

**Status**: Completed
**Date**: 2025-11-05
**Priority**: Medium
**Dependencies**: T002, T003

## Goal
Delete a macro with confirmation prompt

## What Was Done

1. **Validates arguments**
   - Checks name argument provided
   - Returns error with usage if missing

2. **Checks macro exists**
   - Validates file exists at `~/.config/fish/functions/<name>.fish`
   - Returns error if not found

3. **Confirmation prompt**
   - Uses Fish's `read -P` for interactive prompt
   - Asks: "Remove macro '<name>'? [y/N]"
   - Only proceeds if user confirms with 'y' or 'Y'

4. **Removes file**
   - Deletes function file with `rm -f`
   - Shows success message
   - Handles errors gracefully

## Files Modified
- `lib/fish-macro/functions/macro.fish` - Implemented `__fish_macro_remove`

## Next Steps
Part of batch completion with T006 and T008
