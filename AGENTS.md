# Agent Guidelines for ht_tui

## Build Commands

### Primary Commands
- `zig build` - Build the executable (installs to zig-out/)
- `zig build run` - Build and run the application
- `zig build test` - Run all tests

### Running Single Tests
- Run a specific test: `zig test path/to/file.zig --test-filter <test_name>`
- Run tests in a specific file: `zig test path/to/file.zig`

### Optimization Modes
- Debug mode: `zig build`
- ReleaseFast: `zig build -Drelease-fast`
- ReleaseSafe: `zig build -Drelease-safe`
- ReleaseSmall: `zig build -Drelease-small`

## Project Structure

```
ht_tui/
├── build.zig           # Build configuration
├── build.zig.zon       # Package manifest
├── src/
│   ├── main.zig        # Entry point
│   └── render/         # Rendering components
│       ├── Screen.zig  # Screen/Terminal handling
│       └── Style.zig   # Text styling
└── doc/                # Documentation
```

## Code Style Guidelines

### Imports
- Use `const` for imports: `const std = @import("std");`
- Import specific subsystems when appropriate: `const posix = std.posix;`
- Import at module root, not inside functions

### Type Definitions
- Use `@This()` pattern for struct definitions at module level
- Define struct as first line after imports: `const Screen = @This();`
- Group related fields together

### Naming Conventions

**Struct/Enum Fields:**
- PascalCase for fields in types (e.g., `Bold`, `Dim`, `Italic`)
- Descriptive names that convey purpose

**Functions:**
- camelCase for function names (e.g., `makeRaw`, `compare`)
- Use `fn` keyword for all function definitions
- Private functions: lowercase or underscore prefix

**Constants/Variables:**
- camelCase for local variables (e.g., `state`, `raw`)
- Use descriptive names, avoid abbreviations

### Formatting
- 4-space indentation (Zig default)
- No trailing whitespace
- Blank lines between logical sections
- Consistent spacing around operators

### Error Handling
- Use `try` for simple error propagation: `const state = try posix.tcgetattr(fd);`
- Use `!void` or `!T` return types for functions that can fail
- Handle errors appropriately based on context

### Comments
- Use `///` for documentation comments (doc comments)
- Use `//` for inline comments
- Comments can be in English or Chinese (existing code uses both)
- Reference external specs when appropriate (e.g., `see termios(3)`)

### Testing
- Use `test` blocks for unit tests
- Write tests alongside implementation in same file
- Test blocks can use `try` and should be comprehensive
- When fixing bugs, add tests to prevent regressions

### Code Organization

**File-level:**
- Imports at top
- Type/struct definitions
- Public functions
- Private helper functions
- Test blocks

**Function-level:**
- Keep functions focused and small
- Extract complex logic to helper functions
- Use early returns when appropriate

## Zig Version
Minimum Zig version: 0.15.2 (specified in build.zig.zon)

## Terminal/TUI Specifics

This is a terminal UI library dealing with:
- ANSI escape sequences (see doc/ANSI.md for reference)
- Terminal control with POSIX APIs
- Raw mode handling
- Screen manipulation and styling

When working with terminal code:
- Restore terminal state on cleanup
- Handle errors gracefully (e.g., restore termios on failure)
- Test in actual terminal when possible
- Be mindful of terminal compatibility

## Development Workflow

1. Make changes
2. Build: `zig build`
3. Run: `zig build run`
4. Test: `zig build test`
5. Test specific functionality: `zig test src/module.zig --test-filter testName`

## Notes
- No existing test framework beyond Zig's built-in testing
- Build system is Zig's native build system (not Make, CMake, etc.)
- No package manager dependencies currently
- Project is in early development (version 0.0.0)
