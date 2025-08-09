# Guidelines

## Communication Rules

- **MUST**: Always think in English.
- **MUST**: Write all code comments in Japanese.
- **MUST**: Use Japanese for all communication.

## Security

- **MUST**: Never hardcode API keys, passwords, or tokens directly in code
- **MUST**: Load sensitive information from environment variables or config files
- **MUST**: Verify .gitignore includes files containing sensitive information
- **MUST**: Implement validation and sanitization for all user inputs
- **AVOID**: Logging sensitive information even for debugging purposes

## Feedback Format

- **MUST**: Provide concise progress updates for multi-step tasks
- **SHOULD**: Ask for confirmation before:
  - Deleting files or directories
  - Making breaking changes to APIs
  - Modifying configuration files
  - Installing new dependencies
- **PREFER**: Use bullet points for listing multiple items or results
