import 'package:fake_firebase_security_rules/src/access_type.dart';

class FakeFirebaseSecurityRules {
  FakeFirebaseSecurityRules(String securityRules) {
    // Parses security rules into List<PathMatch>.
  }

  bool isAllowed(String path, AccessType accessType) {
    return false;
  }
}
