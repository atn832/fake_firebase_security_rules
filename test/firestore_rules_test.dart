import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';
import 'package:fake_firebase_security_rules/src/parser.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';
import 'package:fake_firebase_security_rules/src/path_segment/const_path_segment.dart';
import 'package:fake_firebase_security_rules/src/path_segment/variable_path_segment.dart';
import 'package:logger/logger.dart';
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

final wildcardDescription = '''
service cloud.firestore {
  match /databases/{database}/documents {
    // Matches any document in the cities collection as well as any document
    // in a subcollection.
    match /cities/{document=**} {
      allow read, write: true;
    }
    match /languages/{regions=**}/city/{city} {
      allow read: if city in ['paris', 'london'];
    }
  }
}
''';

// https://firebase.google.com/docs/rules/rules-and-auth#define_custom_user_information
// Everyone can read /databases/{database}/documents, but only admins can write.
// In /databases/{database}/documents/some_collection/{document}, only writers
// can write and only readers can read.
const claimsDefinition = '''
service cloud.firestore {
  match /databases/{database}/documents {
    // For attribute-based access control, check for an admin claim
    allow write: if request.auth.token.admin == true;
    allow read: true;

    // Alternatively, for role-based access, assign specific roles to users
    match /some_collection/{document} {
      allow read: if request.auth.token.reader == true;
      allow write: if request.auth.token.writer == true;
    }
  }
}
''';

// https://firebase.google.com/docs/rules/data-validation
const unsupportedResourceDefinition = '''
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow the user to read data if the document has the 'visibility'
    // field set to 'public'
    match /cities/{city} {
      allow read: if resource.data.visibility == 'public';
    }
  }
}''';
// https://firebase.google.com/docs/rules/insecure-rules
const unsupportedRequestResourceDefinition = '''
// Content owner only
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow only authenticated content owners access
    match /some_collection/{document} {
      allow read, write: if request.auth != null && request.auth.uid == request.resource.data.author_uid
    }
  }
}''';
const unsupportedGetDefinition = '''
// Role-based access
service cloud.firestore {
  match /databases/{database}/documents {
    // Assign roles to all users and refine access based on user roles
    match /some_collection/{document} {
     allow read: if get(/databases/\$(database)/documents/users/\$(request.auth.uid)).data.role == "Reader"
     allow write: if get(/databases/\$(database)/documents/users/\$(request.auth.uid)).data.role == "Writer"

     // Note: Checking for roles in your database using `get` (as in the code
     // above) or `exists` carry standard charges for read operations.
    }
  }
}''';

// https://firebase.google.com/docs/rules/rules-language#function
const unsupportedFunctionDefinition = '''
service cloud.firestore {
  match /databases/{database}/documents {
    // True if the user is signed in or the requested data is 'public'
    function signedInOrPublic() {
      return request.auth.uid != null || resource.data.visibility == 'public';
    }

    match /cities/{city} {
      allow read, write: if signedInOrPublic();
    }

    match /users/{user} {
      allow read, write: if signedInOrPublic();
    }
  }
}''';

const unsupportedTimestampDefinition = '''
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if
          request.time < timestamp.date(2023, 11, 20);
    }
  }
}''';

void main() {
  group('Parser', () {
    test('parse', () {
      final services = Parser().parse(securityRulesDescription);
      expect(services.length, 1);
      final service = services.first;
      expect(service.pathMatches.length, 1);
      expect(service.pathMatches.first.allowStatements.length, 2);
      expect(service.pathMatches.first.pathSegments, [
        ConstPathSegment('databases'),
        VariablePathSegment('database'),
        ConstPathSegment('documents')
      ]);
    });
    test('nested paths', () {
      final service =
          Parser().parse(completeAndPartialMatchesDescription).first;
      expect(service.pathMatches[0].pathSegments,
          [ConstPathSegment('example'), VariablePathSegment('singleSegment')]);
      expect(service.pathMatches[0].children[0].pathSegments,
          [ConstPathSegment('nested'), ConstPathSegment('path')]);
    });
    test('authUidDescription', () {
      final service = Parser().parse(authUidDescription);
      expect(service.length, 1);
      expect(service.first.pathMatches.length, 1);
      expect(service.first.pathMatches.first.allowStatements.isEmpty, isTrue);
      expect(service.first.pathMatches.first.children.length, 1);
      expect(
          service.first.pathMatches.first.children.first.allowStatements.length,
          1);
    });

    test('wildcardDescription', () {
      final service = Parser().parse(wildcardDescription);
      expect(service.length, 1);
      expect(service.first.pathMatches.length, 1);
      expect(service.first.pathMatches.first.children.length, 2);
    });
  });

  group('Method', () {
    test('read contains related methods', () {
      expect(Method.read.includes(Method.list), isTrue);
      expect(Method.read.includes(Method.read), isTrue);
      expect(Method.read.includes(Method.update), isFalse);
    });
    test('write contains related methods', () {
      expect(Method.write.includes(Method.write), isTrue);
      expect(Method.write.includes(Method.update), isTrue);
      expect(Method.write.includes(Method.delete), isTrue);
      expect(Method.write.includes(Method.list), isFalse);
    });
    test('update only includes update', () {
      expect(Method.update.includes(Method.update), isTrue);
      expect(Method.update.includes(Method.write), isFalse);
      expect(Method.update.includes(Method.delete), isFalse);
      expect(Method.update.includes(Method.list), isFalse);
    });
  });

  test('List<Method>. read/write encompasses all methods', () {
    for (final method in Method.values) {
      expect([Method.read, Method.write].includes(method), isTrue);
    }
  });

  group('FakeFirebaseSecurityRules', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('isAllowed', () {
      final securityRules = FakeFirebaseSecurityRules(securityRulesDescription);
      expect(securityRules.isAllowed('databases/users/documents', Method.read),
          isTrue);
      expect(securityRules.isAllowed('databases/users/documents', Method.write),
          isFalse);
    });
    test('partial and complete matches', () {
      final securityRules =
          FakeFirebaseSecurityRules(completeAndPartialMatchesDescription);
      expect(securityRules.isAllowed('example/hello/nested/path', Method.read),
          isTrue);
    });

    test('auth', () {
      final securityRules = FakeFirebaseSecurityRules(authUidDescription);
      final uid = 'a57293b';
      expect(
          securityRules.isAllowed(
              'databases/some-database/documents/users/$uid', Method.read,
              variables: {
                'request': {
                  'auth': {'uid': uid}
                }
              }),
          isTrue);
    });

    test('wildcards and in', () {
      final securityRules = FakeFirebaseSecurityRules(wildcardDescription);
      expect(
          securityRules.isAllowed(
              'databases/db1/documents/cities/paris', Method.read),
          isTrue);
      expect(
          securityRules.isAllowed(
              'databases/db1/documents/cities/paris/arrondissement14',
              Method.read),
          isTrue);
      expect(
          securityRules.isAllowed(
              'databases/db1/documents/languages/france/idf/city/paris',
              Method.read),
          isTrue);
      expect(
          securityRules.isAllowed(
              'databases/db1/documents/languages/france/idf/city/lyon',
              Method.read),
          isFalse);
    });

    test('recursive custom claims', () async {
      final securityRules = FakeFirebaseSecurityRules(claimsDefinition);
      final variables = {
        'request': {
          'auth': {
            'token': {'admin': true}
          }
        }
      };
      // Can write the root.
      expect(
          securityRules.isAllowed('databases/db1/documents', Method.write,
              variables: variables),
          isTrue);
      // Cannot access outside the root.
      expect(
          securityRules.isAllowed('databases/db1/other-documents', Method.write,
              variables: variables),
          isFalse);
      // Cannot write because admin is not a writer.
      expect(
          securityRules.isAllowed(
              'databases/db1/documents/some_collection/painting', Method.write,
              variables: variables),
          isFalse);
    });
    group('warnings show up nicely', () {
      test('null exceptions', () async {
        final capture = CaptureLogOutput();
        final logger = Logger(output: capture);
        final securityRules =
            FakeFirebaseSecurityRules(claimsDefinition, logger: logger);
        final variables = {
          'request': {'auth': null}
        };
        // No token, it triggers a null exception, and should be interpreted as
        // false.
        expect(
            securityRules.isAllowed('databases/db1/documents', Method.write,
                variables: variables),
            isFalse);
        expect(
            capture.outputs,
            contains(
                'Permission check for write on databases/db1/documents threw a runtime exception'));
      });
      test('unsupported features', () async {
        for (final entry in [
          [unsupportedResourceDefinition, 'resource'],
          [unsupportedRequestResourceDefinition, 'request.resource'],
          [unsupportedGetDefinition, 'get'],
          [unsupportedFunctionDefinition, 'functions'],
          [unsupportedTimestampDefinition, 'timestamp']
        ]) {
          final capture = CaptureLogOutput();
          final definition = entry.first;
          final featureName = entry.last;
          try {
            Logger l = Logger(output: capture);
            // Try compiling the definition.
            FakeFirebaseSecurityRules(definition, logger: l);
          } catch (_) {
            // Ignore CEL exceptions.
          } finally {
            expect(
                capture.outputs, contains('does not support `$featureName`'));
          }
        }
      });
    });
  });
}

class CaptureLogOutput implements LogOutput {
  final List<String> _outputs = [];

  String get outputs => _outputs.join('\n');

  @override
  Future<void> destroy() {
    return Future.value();
  }

  @override
  Future<void> init() {
    return Future.value();
  }

  @override
  void output(OutputEvent event) {
    _outputs.addAll(event.lines);
  }
}
