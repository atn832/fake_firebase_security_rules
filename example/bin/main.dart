import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';

final securityRulesDescription = '''service cloud.firestore {
  match /databases/{database}/documents {
    // For attribute-based access control, check for an admin claim
    allow write: false;
    allow read: true;
  }
}''';

void main(List<String> args) async {
  final securityRules = FakeFirebaseSecurityRules(securityRulesDescription);
  // Prints out `false`.
  print(securityRules.isAllowed('/databases/users/documents', Method.write));
  // Prints out `true`.
  print(securityRules.isAllowed('/databases/users/documents', Method.read));
  // Prints out `false`.
  print(securityRules.isAllowed(
      '/databases/users/documents/too-deep', Method.read));
}
