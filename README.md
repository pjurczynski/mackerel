# fish-macro

Quick function creator for Fish shell, built from your command history.

## What it does

Create, edit, and manage shell functions by selecting from your recent command history in
your editor.

## Commands

```fish
macro add <name>        # Create new function from history
macro edit <name>       # Edit existing macro
macro list              # Show all defined macros
macro remove <name>     # Delete a macro
macro promote <name> <new_name>  # Rename to more descriptive name
```

## How it works

1. Run `macro add g`
2. Your editor opens with your last 50 commands
3. Delete the commands you don't want
4. Save and quit
5. Function `g` is now available

## Configuration

- **History size**: Shows last 50 commands when creating a macro
- **Storage**: Functions saved to `~/.config/fish/functions/<name>.fish`
- **Editor**: Uses your `$EDITOR` environment variable

## Installation

From the project directory:

```fish
fish install.fish
```

This copies all function files to `~/.config/fish/functions/`. The `macro` command will
be available immediately.

## Examples

### Quick one-letter shortcuts

Create a macro for git status:

```fish
$ macro add g
# Editor opens with your last 50 commands
# Delete everything except: git status
# Save and quit

$ g
# Runs: git status
```

### Multi-command macros

Create a macro that does multiple things:

```fish
$ macro add d
# In editor, keep these lines:
#   docker ps
#   docker images
# Save and quit

$ d
# Runs both commands
```

### List your macros

```fish
$ macro list
g: git status
d: docker ps; docker images
```

### Edit a macro

```fish
$ macro edit g
# Editor opens with the function file
# Make changes, save, quit
```

### Promote to descriptive name

When a macro proves useful, give it a better name:

```fish
$ macro promote g git-status
Promoted macro: g → git-status

$ git-status
# Runs: git status
```

### Remove a macro

```fish
$ macro remove d
Remove macro 'd'? [y/N] y
Removed macro: d
```

## Workflow

Typical usage pattern:

1. **Experiment** - Try commands in your shell
2. **Create** - `macro add x` to save the useful ones
3. **Refine** - `macro edit x` to adjust as needed
4. **Promote** - `macro promote x better-name` when you want to keep it
5. **Clean** - `macro remove x` for the ones you don't need

## Requirements

- Fish shell 3.0+
- Text editor ($EDITOR or vi)

## Project Structure

```
lib/fish-macro/
├── functions/          # Fish function implementations
├── install.fish        # Installation script
├── TESTING.md         # Manual testing checklist
├── README.md          # This file
└── docs/              # Additional documentation
```
