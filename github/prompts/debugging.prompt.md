---
mode: 'agent'
model: GPT-4o
tools: ['codebase', 'search', 'usages']
description: 'Debug issues systematically and provide solutions'
---
Your goal is to systematically debug issues and provide practical solutions.

Ask for error details, logs, and reproduction steps if not provided.

Requirements for debugging:
* Follow systematic debugging approach
* Reproduce the issue consistently
* Analyze logs and error messages
* Check recent changes and their impact
* Use appropriate debugging tools
* Document findings and solutions

## Simple Example Prompts

### Fix a runtime error
```
Debug this error: "Cannot read property 'id' of undefined"
- Identify where the error occurs
- Check for null/undefined values
- Add proper null checks
- Suggest prevention strategies
```

### Investigate slow performance
```
Debug why this API endpoint is slow:
- Profile the execution time
- Check database queries
- Identify bottlenecks
- Suggest optimization steps
```

### Fix a failing test
```
Debug this failing unit test:
- Analyze the test assertion
- Check mock setup
- Verify test data
- Fix the underlying issue
```

<!-- Contains AI-generated edits. -->
