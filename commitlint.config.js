module.exports = {
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'refactor',
        'chore',
        'docs',
        'test',
        'style',
        'build',
        'ci',
        'perf',
        'revert'
      ]
    ],
    'type-empty': [2, 'never'],
    'subject-empty': [2, 'never']
  }
};
