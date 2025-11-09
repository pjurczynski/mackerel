# T005: Implement macro edit <name>

**Status**: Completed
**Date**: 2025-11-05
**Priority**: Medium
**Dependencies**: T002, T003

## Goal
Allow users to edit existing macro functions

## What Was Done

1. **Implemented argument validation**
   - Checks that name argument is provided
   - Returns error with usage message if missing

2. **Implemented existence check**
   - Checks if function file exists at `~/.config/fish/functions/<name>.fish`
   - Returns clear error with file path if not found

3. **Implemented editor integration**
   - Gets `$EDITOR` environment variable (falls back to `vi`)
   - Opens the function file directly in editor
   - Waits for editor to close

4. **Implemented error handling**
   - Checks editor exit status
   - Returns error if editor failed

5. **Success feedback**
   - Prints: "Edited macro: <name>"

## Files Modified
- `lib/fish-macro/functions/macro.fish` - Replaced `__fish_macro_edit` stub with full
  implementation

## Testing Performed
- ✓ No argument → error with usage message
- ✓ Non-existent macro → error with file path
- ✓ Editor integration logic verified

## Implementation Notes
- Much simpler than `macro add` - just opens existing file
- No content validation needed (user responsible for their edits)
- No conflict checking needed (editing existing file)

## Next Steps
Ready to proceed with T006: Implement macro list command
