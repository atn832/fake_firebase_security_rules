# fake_firebase_security rules

This project simulates Firebase Security Rules used by Firestore and Firebase Storage. Given these request inputs:
* Firebase security rules, eg.

```
service cloud.firestore {
  match /users/{userId}/documents {
    allow read, write: if request.auth.uid == userId;
  }
}
```
* Concrete path and access method, eg /users/abcd/documents, update.

The library computes whether the request should be allowed or not.

## Usage

```dart
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
  print(
      securityRules.isAllowed('/databases/users/documents', AccessType.write));
  // Prints out `true`.
  print(securityRules.isAllowed('/databases/users/documents', AccessType.read));
  // Prints out `false`.
  print(securityRules.isAllowed(
      '/databases/users/documents/too-deep', AccessType.read));
}
```

## How it works

`FirestoreRules.g4` describes a grammar that parses security rules into Matches. A Match contains a path, made up of segments. Some segments might be variables or wildcards. The expression at the right of allow statements is in Common Expression Language (CEL). CEL is a language used by many security projects. See the [CEL specs](https://github.com/google/cel-spec).

1. Upon initialization, FakeFirebaseSecurityRules parses security rules into a tree of Matches.
1. When a request comes in, FakeFirebaseSecurityRules finds the first Match and allow statement that corresponds to the given path and whose CEL expression evaluates to `true`.

## Try it out

```sh
dart example/firestore_rules_example.dart grammars/6_single_read_write.txt
```

## Generating the parser

```sh
cd grammar
antlr -Dlanguage=Dart FirestoreRules.g4
```

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Differences between Firebase Rules CEL and standard CEL

* Timestamps. Firebase Rules uses its own [Timestamp](https://firebase.google.com/docs/reference/rules/rules.Timestamp)
 implementation while CEL uses `google.protobuf.Timestamp` ([spec](https://github.com/google/cel-spec/blob/master/doc/langdef.md#abstract-types)).

 ## Further readings

* Custom claims
    * <https://firebase.google.com/docs/auth/admin/custom-claims>
    * <https://firebase.google.com/docs/rules/rules-and-auth>
