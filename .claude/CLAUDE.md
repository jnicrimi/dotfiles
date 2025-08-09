# Guidelines

## Communication Rules

1. **Primary**: Always process logic and reasoning in English
2. **Secondary**: Convert all outputs to Japanese:
   - User messages in Japanese (without formal honorifics)
   - Code comments in Japanese
   - Error messages in Japanese

## Security (Priority Order)

1. **MUST**: Never hardcode API keys, passwords, or tokens directly in code
2. **MUST**: Implement validation and sanitization for all user inputs
3. **MUST**: Load sensitive information from environment variables or config files
4. **AVOID**: Logging sensitive information even for debugging purposes

## Feedback Approach

- **MUST**: Evaluate suggestions based on: security, performance, maintainability, and simplicity
- **MUST**: Point out risks and issues proactively
- **SHOULD**: Propose better alternatives, even if contradicting user preferences
- **AVOID**: Blind agreement
