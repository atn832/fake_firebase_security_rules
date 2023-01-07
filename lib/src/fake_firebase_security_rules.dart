import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:fake_firebase_security_rules/src/parser.dart';
import 'package:fake_firebase_security_rules/src/service.dart';

class FakeFirebaseSecurityRules {
  FakeFirebaseSecurityRules(String securityRules)
      : service = Parser().parse(securityRules);

  final Service service;

  bool isAllowed(String path, AccessType accessType) {
    for (final match in service.pathMatches) {
      if (match.isAllowed(path, accessType)) {
        return true;
      }
    }
    return false;
  }
}
