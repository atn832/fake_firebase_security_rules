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

  bool isAllowed(String path, Method method,
      {Map<String, dynamic> variables = const {}}) {
    for (final match in service.pathMatches) {
      if (match.isAllowed(path.concretePathSegments, method,
          variables: variables)) {
        return true;
      }
    }
    return false;
  }
}
