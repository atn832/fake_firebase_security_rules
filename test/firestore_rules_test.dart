import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';
import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/parser.dart';
import 'package:fake_firebase_security_rules/src/path_segment.dart';
import 'package:test/test.dart';

final securityRulesDescription = '''service cloud.firestore {
  match /databases/{database}/documents {
    // For attribute-based access control, check for an admin claim
    allow write: false;
    allow read: true;
  }
}''';

// https://firebase.google.com/docs/rules/rules-language#match
final completeAndPartialMatchesDescription = '''
// Given request.path == /example/hello/nested/path the following
// declarations indicate whether they are a partial or complete match and
// the value of any variables visible within the scope.
service cloud.firestore {
  // Partial match.
  match /example/{singleSegment} {   // `singleSegment` == 'hello'
    allow write;                     // Write rule not evaluated.
    // Complete match.
    match /nested/path {             // `singleSegment` visible in scope.
      allow read;                    // Read rule is evaluated.
    }
  }
  // Complete match.
  match /example/{multiSegment=**} { // `multiSegment` == /hello/nested/path
    allow read;                      // Read rule is evaluated.
  }
}''';

void main() {
  group('Parser', () {
    test('parse', () {
      final service = Parser().parse(securityRulesDescription);
      expect(service.pathMatches.length, 1);
      expect(service.pathMatches.first.allowStatements.length, 2);
      expect(service.pathMatches.first.pathSegments, [
        ConstPathSegment('databases'),
        VariablePathSegment('database'),
        ConstPathSegment('documents')
      ]);
    });
    test('nested paths', () {
      final service = Parser().parse(completeAndPartialMatchesDescription);
      expect(service.pathMatches[0].pathSegments,
          [ConstPathSegment('example'), VariablePathSegment('single')]);
      expect(service.pathMatches[0].children[0].pathSegments,
          [ConstPathSegment('nested'), ConstPathSegment('path')]);
      print(service);
    });
  });

  group('FakeFirebaseSecurityRules', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('isAllowed', () {
      final securityRules = FakeFirebaseSecurityRules(securityRulesDescription);
      expect(securityRules.isAllowed('/databases/users/documents', Method.read),
          isTrue);
      expect(
          securityRules.isAllowed('/databases/users/documents', Method.write),
          isFalse);
    });
    test('partial and complete matches', () {
      final securityRules =
          FakeFirebaseSecurityRules(completeAndPartialMatchesDescription);
      expect(securityRules.isAllowed('/example/hello/nested/path', Method.read),
          isTrue);
    });
  });
}
