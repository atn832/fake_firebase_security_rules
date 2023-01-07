import 'package:equatable/equatable.dart';

abstract class PathSegment extends Equatable {
  @override
  bool? get stringify => true;
}

class ConstPathSegment extends PathSegment {
  ConstPathSegment(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

class VariablePathSegment extends PathSegment {
  VariablePathSegment(this.variableName);

  final String variableName;

  @override
  List<Object?> get props => [variableName];
}
