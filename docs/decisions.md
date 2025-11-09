# Design Decisions

This document records key design decisions made for fish-macro.

## D001: Raw History Display

**Decision**: Show raw, unfiltered history when creating macros.

**Rationale**:
- User has full control via editor - they can delete anything
- Simpler implementation - no filtering logic needed
- Avoids guessing what user wants to see/hide
- Duplicates might be intentional (repeated commands to include)

**Status**: Decided

**Date**: 2025-11-05

## D002: Abort on Empty Function

**Decision**: Abort macro creation if user deletes all commands in editor.

**Rationale**:
- Empty functions serve no purpose
- Could cause confusion later ("why does this function exist?")
- Better to explicitly abort with clear message
- User can always re-run if they changed their mind

**Implementation**: Check if edited content has any commands, show error and exit if empty.

**Status**: Decided

**Date**: 2025-11-05

## D003: Promotion Deletes Original

**Decision**: When promoting a macro, delete the original function.

**Rationale**:
- Clean namespace - no duplicate functions
- Forces conscious choice to use proper name
- Original name becomes available for new macro
- Promotion means "this is graduating" not "this needs both names"

**Implementation**: `macro promote g git-status` creates `git-status` and removes `g`.

**Status**: Decided

**Date**: 2025-11-05

## D004: Conflict Handling

**Decision**: Check for naming conflicts before creating or promoting macros.

**Rules**:
- If target name is an existing function/abbreviation/command → **Error and abort**
- If target name is an existing macro → **Warn and overwrite**

**Applies to**:
- `macro add <name>` - checks the name
- `macro promote <name> <new_name>` - checks the new name

**Rationale**:
- Prevent accidentally shadowing important commands
- Allow intentional macro overwriting
- User stays in control

**Implementation**: Check `type -t <name>` to detect conflicts.

**Status**: Decided

**Date**: 2025-11-05

## D005: No Name Length Restrictions

**Decision**: Allow any valid Fish function name - no length restrictions.

**Rationale**:
- Maximum flexibility for users
- Some users may prefer two-letter shortcuts (gs, dc, etc.)
- Others may want descriptive names from the start
- Fish already validates function names - no need to add extra rules
- "Macro" doesn't have to mean "one-letter"

**Validation**: Use Fish's native function name validation rules.

**Status**: Decided

**Date**: 2025-11-05

## D006: Multi-line Commands Preserved

**Decision**: Show multi-line commands as-is in the editor.

**Rationale**:
- Preserves original formatting and readability
- User can see exactly what was executed
- Editing multi-line commands in editor is natural
- No data loss or transformation
- Simpler implementation - no parsing/reformatting needed

**Implementation**: Extract commands from history without modification.

**Status**: Decided

**Date**: 2025-11-05

## D007: Directory-Agnostic Macros

**Decision**: Macros execute from current working directory, not where they were created.

**Rationale**:
- Standard shell function behavior - no magic
- More flexible and predictable
- User can explicitly add `cd` commands if needed
- Avoids confusion about "hidden" directory changes
- Simpler implementation

**Implementation**: Generate plain Fish functions without directory tracking.

**Status**: Decided

**Date**: 2025-11-05

## D008: Installation via install.fish Script

**Decision**: Provide install.fish script for installation.

**Rationale**:
- Self-contained, no external dependencies
- One-liner installation experience
- Works in monorepo context
- Easy to version and maintain alongside code
- Users can review script before running

**Implementation**: Create `install.fish` that downloads/copies function files to
`~/.config/fish/functions/`.

**Usage**: `curl -sS <url>/install.fish | fish` or download and run locally.

**Status**: Decided

**Date**: 2025-11-05

## D009: No Configuration File

**Decision**: No config file. Use hardcoded defaults.

**Rationale**:
- Keep it simple - fewer moving parts
- Only one setting currently (history size = 50)
- Avoid configuration complexity for minimal benefit
- Users can fork and modify if they need customization
- Can add config later if genuinely needed

**Implementation**: Hardcode defaults in function implementations.

**Status**: Decided

**Date**: 2025-11-05

## D010: Simple List Output Format

**Decision**: Use simple text format for `macro list`.

**Rationale**:
- Easy to read and scan
- No formatting complexity
- Matches the tool's overall simplicity philosophy
- Still scriptable if needed

**Format**: `<name>: <command(s)>` one per line

**Example**:
```
g: git status
d: docker ps
gs: git status && git log --oneline -5
```

**Status**: Decided

**Date**: 2025-11-05
