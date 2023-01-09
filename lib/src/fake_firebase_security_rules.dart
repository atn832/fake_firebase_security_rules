import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/parser.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';
import 'package:fake_firebase_security_rules/src/service.dart';

class FakeFirebaseSecurityRules {
  FakeFirebaseSecurityRules(String securityRules)
      : service = Parser()
            .parse(securityRules)
            .firstWhere((service) => service.name == 'cloud.firestore');

  final Service service;

  /// Evaluates whether an operation is allowed or not. `path` is the full path
  /// from root without a starting '/'.
  bool isAllowed(String path, Method method,
      {Map<String, dynamic> variables = const {}}) {
    assert(!path.startsWith('/'));
    for (final match in service.pathMatches) {
      if (match.isAllowed(path.concretePathSegments, method,
          variables: variables)) {
        return true;
      }
    }
    return false;
  }
}
