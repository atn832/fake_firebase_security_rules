import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/path_match_result.dart';

abstract class PathSegment extends Equatable {
  @override
  bool? get stringify => true;

  List<PathMatchResult> getPotentialMatches(List<String> concretePathSegments);
}
