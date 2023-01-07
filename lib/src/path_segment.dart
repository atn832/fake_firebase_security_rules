import 'package:equatable/equatable.dart';

abstract class PathSegment extends Equatable {
  bool matches(String concretePathSegment);

  @override
  bool? get stringify => true;
}

class ConstPathSegment extends PathSegment {
  ConstPathSegment(this.name);

  final String name;

  @override
  List<Object?> get props => [name];

  @override
  bool matches(String concretePathSegment) => concretePathSegment == name;
}

class VariablePathSegment extends PathSegment {
  VariablePathSegment(this.variableName);

  final String variableName;

  @override
  List<Object?> get props => [variableName];

  @override
  bool matches(String concretePathSegment) => true;
}
