# Manual Testing Checklist

This document contains a comprehensive manual testing checklist for fish-macro.

## Installation

- [ ] Run `fish install.fish` from project root
- [ ] Verify files copied to `~/.config/fish/functions/`
- [ ] Verify `macro` command is available in new shell

## Help Text

- [ ] `macro` (no args) shows help
- [ ] `macro --help` shows help
- [ ] `macro -h` shows help
- [ ] `macro help` shows help

## Invalid Commands

- [ ] `macro invalid` shows error with hint to run --help
- [ ] `macro xyz` shows error with hint to run --help

## macro add <name>

### Happy Path
- [ ] `macro add g` opens editor with history
- [ ] Delete unwanted commands, save, quit
- [ ] Verify function created at `~/.config/fish/functions/g.fish`
- [ ] Run `g` to test the macro works
- [ ] `macro list` shows the new macro

### Edge Cases
- [ ] `macro add` (no name) shows error
- [ ] `macro add 123` (starts with number) shows validation error
- [ ] `macro add ls` (conflicts with command) shows error
- [ ] `macro add g` (already exists) shows warning but continues
- [ ] Delete all commands in editor → abort with error
- [ ] Cancel editor (e.g., :q! in vim) → shows editor error

## macro edit <name>

### Happy Path
- [ ] `macro edit g` opens existing function in editor
- [ ] Make changes, save, quit
- [ ] Run `g` to verify changes applied

### Edge Cases
- [ ] `macro edit` (no name) shows error
- [ ] `macro edit nonexistent` shows error with file path

## macro list

### Happy Path
- [ ] Create a few macros with `macro add`
- [ ] `macro list` displays all macros with their commands
- [ ] Multi-line commands shown with semicolon separator

### Edge Cases
- [ ] `macro list` with no macros shows "No macros found"
- [ ] `macro list` with non-existent directory shows appropriate message

## macro remove <name>

### Happy Path
- [ ] `macro remove g` prompts for confirmation
- [ ] Enter 'y' → macro deleted
- [ ] Verify file deleted from `~/.config/fish/functions/`
- [ ] `macro list` no longer shows the macro

### Edge Cases
- [ ] `macro remove` (no name) shows error
- [ ] `macro remove nonexistent` shows error
- [ ] Confirmation prompt: enter 'n' → cancelled
- [ ] Confirmation prompt: press Enter → cancelled (default is no)

## macro promote <old> <new>

### Happy Path
- [ ] Create macro: `macro add g`
- [ ] `macro promote g git-status`
- [ ] Verify old file deleted: `~/.config/fish/functions/g.fish`
- [ ] Verify new file exists: `~/.config/fish/functions/git-status.fish`
- [ ] Run `git-status` to verify it works
- [ ] `macro list` shows new name, not old name

### Edge Cases
- [ ] `macro promote` (no args) shows error
- [ ] `macro promote g` (one arg) shows error
- [ ] `macro promote nonexistent newname` shows error (old doesn't exist)
- [ ] `macro promote g 123` shows validation error (invalid new name)
- [ ] `macro promote g ls` shows conflict error (new name conflicts)

## Multi-line Commands

- [ ] Create macro with multi-line command (e.g., for loop)
- [ ] Verify it executes correctly
- [ ] Edit the macro, verify multi-line preserved

## Special Characters

- [ ] Create macro with quotes: `echo "hello world"`
- [ ] Create macro with pipes: `ls | grep fish`
- [ ] Create macro with redirects: `echo foo > file.txt`
- [ ] Create macro with && chains: `cmd1 && cmd2`

## Fish Shell Integration

- [ ] Macros available immediately after creation (no restart needed)
- [ ] Tab completion works for macro names
- [ ] Macros persist across shell sessions
- [ ] Macros work in all directories (not directory-specific)

## Error Handling

- [ ] Invalid $EDITOR → appropriate error message
- [ ] Disk full scenario → appropriate error
- [ ] Permission denied → appropriate error
- [ ] Corrupted function file → graceful handling

## Summary

Total test cases: ~60+

To run these tests:
1. Install fish-macro
2. Work through each section systematically
3. Document any failures or unexpected behavior
4. Test on both fresh installation and with existing functions
