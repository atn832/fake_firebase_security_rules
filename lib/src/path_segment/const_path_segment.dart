import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';

class ConstPathSegment extends PathSegment {
  ConstPathSegment(this.name);

  final String name;

  @override
  List<Object?> get props => [name];

  @override
  bool matches(String concretePathSegment) => concretePathSegment == name;

  @override
  Map<String, String> getNewVariables(String concretePathSegment) =>
      matches(name) ? {} : throw StateError('Names don\'t match.');
}
