class PathMatchResult {
  PathMatchResult(
      {this.remainingConcreteSegments = const [], this.variables = const {}});

  final List<String> remainingConcreteSegments;
  final Map<String, String> variables;
}
