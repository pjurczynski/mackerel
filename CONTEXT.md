# fish-macro

## Problem Statement

When working in Fish shell, users frequently type the same commands or command sequences.
While Fish has `funced` and `funcsave` for creating functions, there's friction in the
workflow:

- You must manually open editor and type/paste commands
- No easy way to browse recent history when creating functions
- Creating quick one-letter shortcuts requires the same effort as creating full functions

## Solution

A macro recording system for Fish shell that allows users to:
1. Trigger macro creation with a simple command
2. See recent command history in an editor
3. Select which commands to include by simply deleting unwanted ones
4. Save as a one-letter function for quick access
5. Later promote useful macros to proper named functions

## Target User

Fish shell users who:
- Work with repetitive command sequences
- Want quick one-letter shortcuts for common tasks
- Prefer editor-based workflows over interactive pickers
- Value speed and minimal friction in their shell workflow

## Success Criteria

- Creating a one-letter function takes < 30 seconds
- Functions are immediately available after creation
- Functions persist across shell sessions
- Easy to edit, list, and manage existing macros
- Can promote macros to full-named functions when they prove useful

## Project Structure

```
lib/fish-macro/
├── functions/              # Fish shell function implementations
│   ├── README.md          # File organization documentation
│   ├── macro.fish         # Main router function (to be implemented)
│   └── __fish_macro_*.fish # Private utility functions (to be implemented)
├── docs/
│   ├── scope.md           # What's in/out of scope
│   ├── decisions.md       # Design decisions log
│   ├── tasks.md           # Current task details
│   └── done/              # Archived completed tasks
│       └── 01-*.md
├── CONTEXT.md             # This file
├── README.md              # User-facing documentation
└── backlog.json           # Task backlog
```

## Current Status

**🎉 PROJECT COMPLETE! 🎉**

**Completed**: T001-T011 (ALL tasks!)

### Implementation Progress
- ✓ Project structure and file organization
- ✓ Shared utility functions (error, conflict, validation)
- ✓ Main router function with help text
- ✓ All core commands: add, edit, list, remove, promote
- ✓ Installation script
- ✓ Testing checklist
- ✓ Complete documentation with examples

## Ready for Use

All functionality implemented and documented. The tool is ready for:
- Installation via `fish install.fish`
- Daily use with all commands working
- Future enhancements as needed
