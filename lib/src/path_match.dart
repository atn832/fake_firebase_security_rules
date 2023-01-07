import 'package:cel/cel.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:fake_firebase_security_rules/src/path_segment.dart';
import 'package:tuple/tuple.dart';

class PathMatch {
  PathMatch(this.pathSegments, this.allowStatements, this.children);

  final List<PathSegment> pathSegments;
  final List<PathMatch> children;
  final List<AllowStatement> allowStatements;
}

typedef AllowStatement = Tuple2<List<AccessType>, Program>;
