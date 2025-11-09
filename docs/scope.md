# Scope Definition

## In Scope

### Core Functionality
- **macro add <letter>** - Create new one-letter function from history
  - Opens editor with last N commands from history
  - User deletes unwanted commands
  - Saves as function in `~/.config/fish/functions/<letter>.fish`
  - Warns if function already exists

- **macro edit <letter>** - Edit existing macro
  - Opens the function file in editor
  - Re-saves after editing

- **macro list** - Display all defined macros
  - Shows letter and command(s) it executes

- **macro remove <letter>** - Delete a macro
  - Removes function file
  - Confirmation prompt

- **macro promote <letter> <new_name>** - Promote to named function
  - Renames function from one-letter to descriptive name
  - Moves file accordingly
  - Original letter becomes alias to new name (TBD)

### Technical Scope
- Works with Fish shell 3.0+
- Stores functions as individual `.fish` files in `~/.config/fish/functions/`
- Uses Fish's native function system
- Integrates with Fish's history command
- Uses user's $EDITOR for editing

### User Experience
- Simple CLI commands with clear feedback
- Editor-based workflow (not interactive picker)
- Immediate availability of created functions
- Persistent across sessions

## Out of Scope

### Features NOT Included (v1)
- **Interactive pickers** (fzf/gum integration) - focusing on editor workflow first
- **Recording mode** (macro start/stop) - simpler history-based approach
- **Multi-letter shortcuts** - only single letters a-z, A-Z, 0-9
- **Parameterized macros** - functions won't accept arguments initially
- **Macro categories/namespaces** - flat structure only
- **Sharing/importing macros** - local use only
- **Macro analytics/usage tracking** - no statistics
- **Undo/versioning** - no history of changes
- **Testing framework integration** - manual testing only initially
- **Multi-command with logic** - no conditionals/loops, just sequential commands

### Explicit Non-Goals
- Not a full shell scripting framework
- Not replacing Fish's native function system
- Not a plugin manager
- Not trying to be cross-shell compatible (Fish only)

## Future Considerations (Post-v1)

- Interactive history selection with fzf
- Support for function parameters
- Two-letter shortcuts for when single letters run out
- Export/import macro sets
- Macro usage statistics
- Integration with version control for dotfiles
