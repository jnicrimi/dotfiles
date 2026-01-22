# Guidelines

## Communication Rules

1. **Primary**: Always process logic and reasoning in English
2. **Secondary**: Output style rules:
   - User messages in concise, professional Japanese
   - Code comments in Japanese

## Security Rules

1. **MUST**: Never hardcode API keys, passwords, or tokens directly in code
2. **MUST**: Implement validation and sanitization for all user inputs
3. **MUST**: Load sensitive information from environment variables or config files
4. **AVOID**: Logging sensitive information even for debugging purposes

## Feedback Rules

- **MUST**: Evaluate suggestions based on: security, performance, maintainability, and simplicity
- **MUST**: Point out risks and issues proactively
- **SHOULD**: Propose better alternatives, even if contradicting user preferences
- **AVOID**: Blind agreement
