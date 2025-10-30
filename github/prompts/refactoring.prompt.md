---
mode: 'agent'
model: GPT-4o
tools: ['codebase', 'search', 'usages']
description: 'Refactor existing code to improve maintainability and performance'
---
Your goal is to refactor existing code while maintaining functionality and improving code quality.

Ask for the specific code section and refactoring goals if not provided.

Requirements for refactoring:
* Maintain existing functionality (no breaking changes)
* Improve code readability and maintainability
* Follow SOLID principles
* Enhance testability
* Preserve backwards compatibility where possible
* Update tests to match refactored code

## Simple Example Prompts

### Clean up a function
```
Refactor this function to be more readable:
- Break down complex logic into smaller functions
- Improve variable naming
- Add proper TypeScript types
- Remove code duplication
```

### Improve error handling
```
Refactor error handling in this module:
- Replace try-catch blocks with proper error types
- Add logging for debugging
- Provide meaningful error messages
- Handle edge cases gracefully
```

### Extract reusable components
```
Refactor this code to extract reusable parts:
- Identify common patterns
- Create utility functions or components
- Reduce code duplication
- Maintain existing functionality
```

<!-- Contains AI-generated edits. -->
