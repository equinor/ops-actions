const Configuration = {
  rules: {
    'type-enum': [2, 'always', ['feat', 'fix', 'wip', 'build', 'ci', 'docs', 'style', 'refactor', 'perf', 'test', 'chore']],
    'scope-enum': [2, 'always', []]
  }
}

module.exports = Configuration
