import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';

class WildcardPathSegment extends PathSegment {
  WildcardPathSegment(this.name);

  // The name without '=**'.
  final String name;

  @override
  Map<String, String> getNewVariables(String concretePathSegment) =>
      {name: concretePathSegment};

  @override
  bool matches(String concretePathSegment) => true;

  @override
  List<Object?> get props => [name];
}
