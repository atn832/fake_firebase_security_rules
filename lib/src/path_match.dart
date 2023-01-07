import 'package:cel/cel.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';

class PathMatch {
  PathMatch(this.accessToProgram, this.children);

  List<PathMatch> children;
  Map<AccessType, Program> accessToProgram;
}
