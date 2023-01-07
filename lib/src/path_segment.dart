abstract class PathSegment {}

class ConstPathSegment extends PathSegment {
  ConstPathSegment(this.name);

  final String name;
}

class VariablePathSegment extends PathSegment {
  VariablePathSegment(this.variableName);

  final String variableName;
}
