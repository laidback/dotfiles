---
mode: 'agent'
model: GPT-4o
tools: ['codebase', 'search', 'findTestFiles']
description: 'Generate comprehensive tests for code components'
---
Your goal is to create comprehensive tests following the project's testing patterns.

Ask for the component/function to test and coverage requirements if not provided.

Requirements for testing:
* Follow existing test patterns in the codebase
* Write unit tests for individual components
* Create integration tests for service interactions
* Include edge cases and error conditions
* Achieve >80% code coverage
* Use descriptive test names and assertions
* Mock external dependencies appropriately

## Simple Example Prompts

### Create unit tests
```
Generate unit tests for this utility function:
- Test all expected inputs and outputs
- Cover edge cases (null, undefined, empty)
- Test error conditions
- Use Jest testing framework
```

### Create API tests
```
Generate integration tests for this API endpoint:
- Test successful requests
- Test error responses (400, 404, 500)
- Verify request/response structure
- Mock database calls
```

### Create React component tests
```
Generate tests for this React component:
- Test rendering with different props
- Test user interactions (clicks, form inputs)
- Test loading and error states
- Use React Testing Library
```

<!-- Contains AI-generated edits. -->
