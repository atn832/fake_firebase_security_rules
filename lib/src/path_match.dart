import 'package:cel/cel.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:fake_firebase_security_rules/src/path_segment.dart';
import 'package:tuple/tuple.dart';

class PathMatch extends Equatable {
  PathMatch(this.pathSegments, this.allowStatements, this.children);

  final List<PathSegment> pathSegments;
  final List<AllowStatement> allowStatements;
  final List<PathMatch> children;

  @override
  List<Object?> get props => [pathSegments, allowStatements, children];

  @override
  bool? get stringify => true;
}

typedef AllowStatement = Tuple2<List<AccessType>, Program>;
