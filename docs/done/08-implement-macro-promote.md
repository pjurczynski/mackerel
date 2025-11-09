# T008: Implement macro promote <name> <new_name>

**Status**: Completed
**Date**: 2025-11-05
**Priority**: Medium
**Dependencies**: T002, T003

## Goal
Rename a macro to a more descriptive name (per D003 - delete original)

## What Was Done

1. **Validates arguments**
   - Checks both old_name and new_name provided
   - Returns error with usage if missing

2. **Validates new name**
   - Uses `__fish_macro_validate_name` for new name
   - Returns error if invalid

3. **Checks old macro exists**
   - Validates old function file exists
   - Returns error if not found

4. **Checks for conflicts (per D004)**
   - Uses `__fish_macro_conflict` for new name
   - Prevents shadowing existing commands/functions
   - Also checks if new name already exists as macro

5. **Renames function (per D003)**
   - Uses `sed` to replace function name in file content
   - Creates new file with new name
   - Deletes original file (per D003 - no aliases)

6. **Success feedback**
   - Shows: "Promoted macro: old_name → new_name"

## Files Modified
- `lib/fish-macro/functions/macro.fish` - Implemented `__fish_macro_promote`

## Design Decisions Applied
- **D003**: Promotion deletes original (no alias created)
- **D004**: Conflict handling for new name

## Next Steps
Part of batch completion with T006 and T007. Core commands now complete!
