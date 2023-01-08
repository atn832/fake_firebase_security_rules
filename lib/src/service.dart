import 'package:equatable/equatable.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';

class Service extends Equatable {
  Service(this.name, this.pathMatches);

  final String name;
  final List<PathMatch> pathMatches;

  @override
  List<Object?> get props => [name, pathMatches];

  @override
  bool? get stringify => true;
}
