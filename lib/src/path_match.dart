import 'package:cel/cel.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/path_match_result.dart';
import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';
import 'package:tuple/tuple.dart';

extension on List<PathSegment> {
  /// Returns whether the beginning of the concrete path matches with its path
  /// segments. By definition, it also returns true if it fully matches.
  List<PathMatchResult> getPotentialMatches(List<String> concretePathSegments) {
    // Full match.
    if (isEmpty && concretePathSegments.isEmpty) {
      return [PathMatchResult()];
    }
    // Partial match.
    if (isEmpty) {
      return [PathMatchResult(remainingConcreteSegments: concretePathSegments)];
    }
    // No match.
    if (concretePathSegments.isEmpty) {
      return [];
    }
    // Recursive case. Evaluate the first segment.
    final potentialMatches = first.getPotentialMatches(concretePathSegments);
    return [
      for (final potentialMatch in potentialMatches) ...[
        for (final potentialSubMatch in sublist(1)
            .getPotentialMatches(potentialMatch.remainingConcreteSegments))
          PathMatchResult(
              remainingConcreteSegments:
                  potentialSubMatch.remainingConcreteSegments,
              variables: {
                ...potentialMatch.variables,
                ...potentialSubMatch.variables
              })
      ]
    ];
  }
}

extension PathSegments on String {
  get concretePathSegments => substring(1).split('/');
}

class PathMatch extends Equatable {
  PathMatch(this.pathSegments, this.allowStatements, this.children);

  final List<PathSegment> pathSegments;
  final List<AllowStatement> allowStatements;
  final List<PathMatch> children;

  bool isAllowed(List<String> concretePathSegments, Method method,
      {required Map<String, dynamic> auth,
      required Map<String, String> variables}) {
    final potentialMatches =
        pathSegments.getPotentialMatches(concretePathSegments);
    for (final potentialMatch in potentialMatches) {
      if (potentialMatch.remainingConcreteSegments.isEmpty) {
        // Full match.
        for (final allowStatement in allowStatements) {
          if (allowStatement.item1.includes(method)) {
            // evaluate the program.
            // TODO: add real inputs, eg Request, now...
            if (allowStatement.item2.evaluate({
              // Put variables
              ...variables,
              // and new variables first...
              ...potentialMatch.variables,
              // So that they can never override the `request` Object.
              ...{
                'request': {'auth': auth}
              }
            })) {
              return true;
            }
          }
        }
        return false;
      }
      // If partial match, check children.
      for (final child in children) {
        if (child.isAllowed(potentialMatch.remainingConcreteSegments, method,
            auth: auth,
            variables: {...variables, ...potentialMatch.variables})) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [pathSegments, allowStatements, children];

  @override
  bool? get stringify => true;
}

typedef AllowStatement = Tuple2<List<Method>, Program>;
