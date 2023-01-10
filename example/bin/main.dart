import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';

// https://firebase.google.com/docs/rules/rules-and-auth#leverage_user_information_in_rules
final authUidDescription = '''
service cloud.firestore {
  match /databases/{database}/documents {
    // Make sure the uid of the requesting user matches name of the user
    // document. The wildcard expression {userId} makes the userId variable
    // available in rules.
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}''';

void main(List<String> args) async {
  final securityRules = FakeFirebaseSecurityRules(authUidDescription);
  final uid = 'a57293b';
  final variables = {
    'request': {
      'auth': {'uid': uid}
    }
  };
  // Prints out `true`.
  print(securityRules.isAllowed(
      'databases/some-database/documents/users/$uid', Method.read,
      variables: variables));
  // Prints out `false`.
  print(securityRules.isAllowed(
      'databases/some-database/documents/users/someone-elses-id', Method.read,
      variables: variables));
  // Prints out `false`.
  print(securityRules.isAllowed(
      'databases/some-database/documents/somewhere-else/someone-doc',
      Method.read,
      variables: variables));
}
