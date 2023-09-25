import 'package:cel/cel.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/path_match_result.dart';
import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';
import 'package:logger/logger.dart';
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
  List<String> get concretePathSegments => split('/');
}

extension Includes on List<Method> {
  /// Whether a list of methods include a given method, eg whether [read, write]
  /// includes update.
  bool includes(Method method) => any((m) => m.includes(method));
}

class PathMatch extends Equatable {
  PathMatch(this.pathSegments, this.allowStatements, this.children);

  final List<PathSegment> pathSegments;
  final List<AllowStatement> allowStatements;
  final List<PathMatch> children;

  bool isAllowed(List<String> concretePathSegments, Method method,
      {required Map<String, dynamic> variables, required Logger logger}) {
    final potentialMatches =
        pathSegments.getPotentialMatches(concretePathSegments);
    for (final potentialMatch in potentialMatches) {
      if (potentialMatch.remainingConcreteSegments.isEmpty) {
        // Full match.
        for (final allowStatement in allowStatements) {
          final program = allowStatement.item2;
          final finalVariables = {
            // Put variables
            ...variables,
            // and new variables first...
            ...potentialMatch.variables,
          };
          if (allowStatement.item1.includes(method)) {
            // Evaluate the program.
            try {
              if (program.evaluate(finalVariables)) {
                return true;
              }
            } catch (e) {
              // If an evaluation throws an error, such as on null exceptions,
              // fail silently and try other matches.
              logger.i(
                  'Permission check for ${method.name} on ${concretePathSegments.join('/')} threw a runtime exception, so it was evaluated to `false`. A null exception is a common cause for such errors.\nProgram: $program\nInput: $finalVariables',
                  error: e);
            }
          }
        }
        return false;
      }
      // If partial match, check children.
      for (final child in children) {
        if (child.isAllowed(potentialMatch.remainingConcreteSegments, method,
            variables: {...variables, ...potentialMatch.variables},
            logger: logger)) {
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
