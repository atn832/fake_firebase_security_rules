import 'package:equatable/equatable.dart';

abstract class PathSegment extends Equatable {
  bool matches(String concretePathSegment);

  @override
  bool? get stringify => true;

  /// Returns new variables generated by the PathSegment. Makes sense only if
  /// the PathSegment `matches` with the concretePathSegment.
  Map<String, String> getNewVariables(String concretePathSegment);
}

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

class VariablePathSegment extends PathSegment {
  VariablePathSegment(this.variableName);

  final String variableName;

  @override
  List<Object?> get props => [variableName];

  @override
  bool matches(String concretePathSegment) => true;

  @override
  Map<String, String> getNewVariables(String concretePathSegment) =>
      {variableName: concretePathSegment};
}
