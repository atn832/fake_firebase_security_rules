import 'package:collection/collection.dart';
import 'package:cel/cel.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:fake_firebase_security_rules/src/path_segment.dart';
import 'package:tuple/tuple.dart';

extension on List<PathSegment> {
  bool matches(String path) {
    // Skip the first /. Might have to revisit later.
    final concretePathSegments = path.substring(1).split('/');
    if (concretePathSegments.length != length) {
      return false;
    }
    return IterableZip([this, concretePathSegments]).every((tuple) {
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

  bool isAllowed(String path, AccessType accessType) {
    if (!pathSegments.matches(path)) {
      return false;
    }
    for (final allowStatement in allowStatements) {
      if (allowStatement.item1.includes(accessType)) {
        // evaluate the program.
        // TODO: add real inputs, eg Request, now...
        if (allowStatement.item2.evaluate({})) {
          return true;
        }
      }
    }
    // TODO: support recursion.
    return false;
  }

  @override
  List<Object?> get props => [pathSegments, allowStatements, children];

  @override
  bool? get stringify => true;
}

typedef AllowStatement = Tuple2<List<AccessType>, Program>;

extension on List<AccessType> {
  /// In theory, it should also support `read.includes(update) ==> true`.
  bool includes(AccessType accessType) {
    return contains(accessType);
  }
}
