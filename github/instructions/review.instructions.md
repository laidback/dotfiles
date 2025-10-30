# Code Review Guidelines

## Review Principles
- Be respectful and constructive
- Focus on the code, not the person
- Explain the reasoning behind suggestions
- Recognize good practices and improvements
- Balance thoroughness with practicality

## What to Review
### Functionality
- [ ] Code does what it's supposed to do
- [ ] Edge cases are handled
- [ ] Error conditions are managed properly
- [ ] Business logic is correct

### Code Quality
- [ ] Code is readable and well-structured
- [ ] Functions have single responsibilities
- [ ] Variable and function names are descriptive
- [ ] Code follows team conventions

### Security
- [ ] Input validation is proper
- [ ] Authentication/authorization is correct
- [ ] Sensitive data is handled securely
- [ ] No hardcoded secrets or credentials

### Performance
- [ ] No obvious performance bottlenecks
- [ ] Database queries are optimized
- [ ] Memory usage is reasonable
- [ ] Caching is used appropriately

### Testing
- [ ] Adequate test coverage
- [ ] Tests are meaningful and not just for coverage
- [ ] Tests cover edge cases
- [ ] Tests are maintainable

## Review Comments
### Good Examples
- "Consider using a Map here for O(1) lookup instead of array.find()"
- "Great use of the factory pattern here!"
- "This error handling looks comprehensive"

### Avoid
- "This is wrong"
- "Bad code"
- "Why did you do this?"

## Response to Reviews
- Thank reviewers for their time
- Ask for clarification if feedback is unclear
- Explain your reasoning when disagreeing
- Be open to learning and improvement

<!-- Contains AI-generated edits. -->
