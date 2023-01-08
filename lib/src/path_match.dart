import 'package:collection/collection.dart';
import 'package:cel/cel.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/path_segment.dart';
import 'package:tuple/tuple.dart';

extension on List<PathSegment> {
  bool matches(String path) {
    // Skip the first /. Might have to revisit later.
    final concretePathSegments = path.substring(1).split('/');
    return concretePathSegments.length == length && partiallyMatches(path);
  }

  /// Returns whether the beginning of the concrete path matches with its path
  /// segments. By definition, it also returns true if it fully matches.
  bool partiallyMatches(String path) {
    // Skip the first /. Might have to revisit later.
    final concretePathSegments = path.substring(1).split('/');

    if (concretePathSegments.length < length) {
      return false;
    }
    return IterableZip([this, concretePathSegments.sublist(0, length)])
        .every((tuple) {
      final pathSegment = tuple.first as PathSegment;
      final concretePathSegment = tuple.last as String;
      return pathSegment.matches(concretePathSegment);
    });
  }
}

class PathMatch extends Equatable {
  PathMatch(this.pathSegments, this.allowStatements, this.children);

  final List<PathSegment> pathSegments;
  final List<AllowStatement> allowStatements;
  final List<PathMatch> children;

  bool isAllowed(String path, Method method) {
    print('isAllowed $path $pathSegments');
    // if partiallyMatches, check children.
    if (pathSegments.partiallyMatches(path)) {
      // Take out the first segments covered by the current PathMatch.
      final subPath = '/' +
          path.substring(1).split('/').sublist(pathSegments.length).join('/');
      for (final child in children) {
        if (child.isAllowed(subPath, method)) {
          return true;
        }
      }
    }
    if (!pathSegments.matches(path)) {
      return false;
    }
    for (final allowStatement in allowStatements) {
      if (allowStatement.item1.includes(method)) {
        // evaluate the program.
        // TODO: add real inputs, eg Request, now...
        if (allowStatement.item2.evaluate({})) {
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
