---
mode: 'agent'
model: GPT-4o
tools: ['githubRepo', 'codebase', 'search']
description: 'Generate new code components following established patterns'
---
Your goal is to generate new code components based on existing patterns in the codebase.

Ask for component type and requirements if not provided.

Requirements for code generation:
* Use TypeScript for all new features
* Follow existing architecture patterns from the codebase
* Include comprehensive error handling
* Add appropriate logging using Winston/Pino
* Write unit tests with >80% coverage
* Follow team coding standards and conventions

## Simple Example Prompts

### Create a basic API endpoint
```
Generate a simple GET endpoint for user profiles:
- Path: /api/users/:id
- Returns user data with basic validation
- Includes error handling for not found
- Uses existing database connection patterns
```

### Create a React component
```
Generate a simple UserCard component:
- Takes user object as props
- Displays name, email, and avatar
- Includes loading and error states
- Uses existing styling patterns
```

### Create a utility function
```
Generate a utility function to format dates:
- Takes date input and format string
- Returns formatted date string
- Handles invalid dates gracefully
- Includes TypeScript types
```

<!-- Contains AI-generated edits. -->
