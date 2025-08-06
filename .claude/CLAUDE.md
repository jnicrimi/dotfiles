# Guidelines

## Communication Rules

- **MUST**: Always think in English.
- **MUST**: Write all code comments in Japanese.
- **MUST**: Use Japanese for all communication.

## Code Implementation Policy

- **MUST**: When the user describes a problem or asks questions, focus on understanding and analysis first

### Existing Code Adaptation

- **MUST**: Follow existing code style and conventions in the codebase
- **MUST**: Check for existing patterns before implementing new solutions
- **SHOULD**: Use existing utilities and helper functions when available

### Minimal Changes

- **PREFER**: Minimal changes that solve the problem
- **AVOID**: Unnecessary refactoring unless explicitly requested
- **AVOID**: Adding new dependencies without user approval

### Code Quality

- **MUST**: Ensure code is syntactically correct before presenting
- **SHOULD**: Consider edge cases and error handling
- **AVOID**: Duplicating code that already exists in the project

### Pre-implementation Verification

- **SHOULD**: Verify file paths and imports before making changes
- **SHOULD**: Check if tests exist and run them after changes
- **MUST**: Preserve existing functionality unless changing it is the goal

### Comments and Documentation

- **ONLY ADD**: comments when explicitly requested or for complex logic
- **AVOID**: Obvious comments that repeat what code does
- **PREFER**: Self-documenting code over excessive comments

## Security

- **MUST**: Never hardcode API keys, passwords, or tokens directly in code
- **MUST**: Load sensitive information from environment variables or config files
- **MUST**: Verify .gitignore includes files containing sensitive information
- **AVOID**: Logging sensitive information even for debugging purposes
- **SHOULD**: Implement validation and sanitization for user inputs

## Performance

- **PREFER**: A readable implementation on the first iteration
- **SHOULD**: Optimize only when clear bottlenecks are identified
- **MONITOR**: Memory usage when processing large datasets
- **AVOID**: Premature optimization
- **MEASURE**: Benchmark performance before and after improvements

## Error Handling

- **MUST**: Report errors with the following structure:
  - Error location (file path and line number)
  - Error message (original error text)
  - Possible causes (2-3 most likely reasons)
  - Suggested solutions
- **MUST**: Include a relevant code snippet when reporting errors
- **SHOULD**: Check for common issues first (syntax errors, missing imports, type mismatches)
- **AVOID**: Overwhelming the user with stack traces unless specifically requested

## Feedback Format

- **MUST**: Provide concise progress updates for multi-step tasks
- **MUST**: Confirm completion of each major task
- **SHOULD**: Ask for confirmation before:
  - Deleting files or directories
  - Making breaking changes to APIs
  - Modifying configuration files
  - Installing new dependencies
- **SHOULD**: Report task progress as: "タスク名: 完了" or "タスク名: 進行中"
- **AVOID**: Excessive explanations unless user requests details
- **PREFER**: Use bullet points for listing multiple items or results
