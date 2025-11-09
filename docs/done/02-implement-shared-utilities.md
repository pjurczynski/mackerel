# T002: Implement Shared Utilities

**Status**: Completed
**Date**: 2025-11-05
**Priority**: High
**Dependencies**: T001

## Goal
Create utility functions: conflict detection, function name validation, and error
messaging helpers

## What Was Done

1. **Created `__fish_macro_error.fish`**
   - Standard error message formatting
   - Outputs to stderr with format: "macro: error: <message>"
   - Returns status code 1

2. **Created `__fish_macro_conflict.fish`**
   - Detects if a name conflicts with existing commands/functions
   - Uses Fish's `type -t` to check for conflicts
   - Returns 0 if conflict exists, 1 if name is available

3. **Created `__fish_macro_validate_name.fish`**
   - Validates function names according to Fish rules
   - Checks for: empty names, names starting with numbers, invalid characters
   - Allows any length (per D005)
   - Returns 0 if valid, 1 if invalid with error message

## Files Created
- `lib/fish-macro/functions/__fish_macro_error.fish`
- `lib/fish-macro/functions/__fish_macro_conflict.fish`
- `lib/fish-macro/functions/__fish_macro_validate_name.fish`

## Testing Performed
- ✓ Error messaging outputs to stderr with correct format
- ✓ Conflict detection finds existing commands (ls, cd)
- ✓ Conflict detection allows new names (nonexistent123)
- ✓ Name validation accepts valid names (a, my-func)
- ✓ Name validation rejects numbers (123)
- ✓ Name validation rejects spaces (has space)

## Design Decisions Referenced
- **D004**: Conflict handling - check for existing commands/functions
- **D005**: No name length restrictions - allow any valid Fish function name

## Next Steps
Ready to proceed with T003: Implement main macro.fish router
