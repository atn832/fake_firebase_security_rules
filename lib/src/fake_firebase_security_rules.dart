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
    // TODO: populate `request` and `resource`.
    // https://firebase.google.com/docs/rules/rules-language#building_conditions
    // https://firebase.google.com/docs/reference/rules/rules.firestore.Request
    // https://firebase.google.com/docs/reference/rules/rules.firestore.Resource
    // `resource` works with get `get` and `exists` custom functions. Enables
    // this kinds of expressions:
    // `get(/databases/(database)/documents/users/$(request.auth.uid)).data.admin)`
    // https://firebase.google.com/docs/rules/rules-language#function
    // TODO: populate `request` with `auth`.
    // https://firebase.google.com/docs/rules/rules-and-auth
    for (final match in service.pathMatches) {
      if (match.isAllowed(path.concretePathSegments, method,
          variables: variables)) {
        return true;
      }
    }
    return false;
  }
}
