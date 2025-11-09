# T006: Implement macro list

**Status**: Completed
**Date**: 2025-11-05
**Priority**: Medium
**Dependencies**: T003

## Goal
Display all defined macros with their commands

## What Was Done

1. **Scans functions directory**
   - Checks if `~/.config/fish/functions/` exists
   - Iterates through all `.fish` files

2. **Parses function files**
   - Extracts function name from filename
   - Reads function content between `function <name>` and `end`
   - Collects all command lines

3. **Formats output (per D010)**
   - Simple format: `<name>: <command>; <command>; ...`
   - Joins multiple commands with semicolons
   - Shows "No macros found" if directory empty

## Files Modified
- `lib/fish-macro/functions/macro.fish` - Implemented `__fish_macro_list`

## Design Decisions Applied
- **D010**: Simple list output format

## Next Steps
Part of batch completion with T007 and T008
