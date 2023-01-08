import 'package:fake_firebase_security_rules/src/path_match_result.dart';
import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';

class WildcardPathSegment extends PathSegment {
  WildcardPathSegment(this.wildcardName);

  // The name without '=**'.
  final String wildcardName;

  @override
  List<PathMatchResult> getPotentialMatches(List<String> concretePathSegments) {
    // No match.
    if (concretePathSegments.isEmpty) {
      return [];
    }
    return [
      for (var i = 1; i <= concretePathSegments.length; i++)
        PathMatchResult(
            remainingConcreteSegments: concretePathSegments.sublist(i),
            variables: {
              wildcardName: concretePathSegments.sublist(0, i).join('/')
            })
    ];
  }

  @override
  List<Object?> get props => [wildcardName];
}
