import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:fake_firebase_security_rules/src/parser.dart';
import 'package:test/test.dart';

final securityRulesDescription = '''service cloud.firestore {
  match /databases/{database}/documents {
    // For attribute-based access control, check for an admin claim
    allow write: false;
    allow read: true;
  }
}''';
void main() {
  group('Parser', () {
    test('parse', () {
      final service = Parser().parse(securityRulesDescription);
      expect(service.pathMatches.length, 1);
      expect(service.pathMatches.first.allowStatements.length, 2);
      print(service);
    });
  });

  group('FakeFirebaseSecurityRules', () {
    final securityRules = FakeFirebaseSecurityRules(securityRulesDescription);

    setUp(() {
      // Additional setup goes here.
    });

    test('isAllowed', () {
      expect(
          securityRules.isAllowed(
              '/databases/users/documents', AccessType.read),
          isTrue);
      expect(
          securityRules.isAllowed(
              '/databases/users/documents', AccessType.read),
          isFalse);
    });
  });
}
