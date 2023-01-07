import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final securityRules = FakeFirebaseSecurityRules('''service cloud.firestore {
  match /databases/{database}/documents {
    // For attribute-based access control, check for an admin claim
    allow write: false;
    allow read: true;
  }
}''');

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
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
