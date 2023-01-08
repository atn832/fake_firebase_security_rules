import 'package:fake_firebase_security_rules/src/path_match_result.dart';
import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';

class ConstPathSegment extends PathSegment {
  ConstPathSegment(this.name);

  final String name;

  @override
  List<PathMatchResult> getPotentialMatches(List<String> concretePathSegments) {
    return [
      if (concretePathSegments.isNotEmpty && concretePathSegments.first == name)
        PathMatchResult(
            remainingConcreteSegments: concretePathSegments.sublist(1))
    ];
  }

  @override
  List<Object?> get props => [name];
}
