import 'package:fake_firebase_security_rules/src/path_match_result.dart';
import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';

class VariablePathSegment extends PathSegment {
  VariablePathSegment(this.variableName);

  final String variableName;

  @override
  List<PathMatchResult> getPotentialMatches(List<String> concretePathSegments) {
    return [
      if (concretePathSegments.isNotEmpty)
        PathMatchResult(
            remainingConcreteSegments: concretePathSegments.sublist(1),
            variables: {variableName: concretePathSegments.first})
    ];
  }

  @override
  List<Object?> get props => [variableName];
}
