import 'package:cel/cel.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:tuple/tuple.dart';

class PathMatch {
  PathMatch(this.allowStatements, this.children);

  List<PathMatch> children;
  List<AllowStatement> allowStatements;
}

typedef AllowStatement = Tuple2<List<AccessType>, Program>;
