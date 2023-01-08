import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';

class VariablePathSegment extends PathSegment {
  VariablePathSegment(this.variableName);

  final String variableName;

  @override
  List<Object?> get props => [variableName];

  @override
  bool matches(String concretePathSegment) => true;

  @override
  Map<String, String> getNewVariables(String concretePathSegment) =>
      {variableName: concretePathSegment};
}
