# fake_firebase_security_rules

[![pub package](https://img.shields.io/pub/v/fake_firebase_security_rules.svg)](https://pub.dartlang.org/packages/fake_firebase_security_rules)
[![Tests](https://github.com/atn832/fake_firebase_security_rules/actions/workflows/dart.yml/badge.svg)](https://github.com/atn832/fake_firebase_security_rules/actions/workflows/dart.yml)

This project simulates [Firebase Security Rules](https://firebase.google.com/docs/rules). It is meant to be used by [Fake Cloud Firestore](https://pub.dev/packages/fake_cloud_firestore) and [Firebase Storage Mocks](https://pub.dev/packages/firebase_storage_mocks). Given these request inputs:

* Firebase security rules such as:

```
service cloud.firestore {
  match /users/{userId}/documents {
    allow read, write: if request.auth.uid == userId;
  }
}
```

* Concrete path, access method, eg an `update` on `/users/abcd/documents`,
* Variables, eg a `Map` such as `{'request': { 'auth': { 'uid': 'efgh' } } }`,

the library computes whether the request should be allowed or not.

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

See the [Unit tests](https://github.com/atn832/fake_firebase_security_rules/blob/main/test/firestore_rules_test.dart) for more advanced examples of usage.

## Features

Supports:

* service declarations for Firestore and Firebase Storage.
* recursive `match` definitions.
* exhaustive path matching with path variables and wildcards, eg `/users/{userId}/{documents=**}`.
* standard CEL types and methods, eg `bool`, `int`, `double`, `String`, `Map`, `List`, `String.match(regexp)`... See [cel-dart's supported features](https://pub.dev/packages/cel#features) for an exhaustive list.

Missing:

* timestamps
* durations

## Implementation details

### Differences between Firebase Rules CEL and standard CEL

* Timestamps. Firebase Rules uses its own [Timestamp](https://firebase.google.com/docs/reference/rules/rules.Timestamp)
 implementation while CEL uses `google.protobuf.Timestamp` ([spec](https://github.com/google/cel-spec/blob/master/doc/langdef.md#abstract-types)).

### How the project works

`FirestoreRules.g4` describes a grammar that parses security rules into Matches. A Match contains a path, made up of segments. Some segments might be variables or wildcards. The expression at the right of allow statements is in Common Expression Language (CEL). CEL is a language used by many security projects. See the [CEL specs](https://github.com/google/cel-spec).

1. Upon initialization, FakeFirebaseSecurityRules parses security rules into a tree of Matches.
1. When a request comes in, FakeFirebaseSecurityRules finds the first Match and allow statement that corresponds to the given path and whose CEL expression evaluates to `true`.

### Working on the grammar

The fastest way to get your environment up and running is to create a [Codespace](https://github.com/features/codespaces) on the repository, then `pip install antlr4-tools`. Once this is done, you can run `antlr4-parse` to try out the rules against some inputs and `antlr4` to regenerate the Parser in `lib/src/parser/gen`.

```sh
cd grammar
# Test the grammar on one file.
antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens 9_custom_claims.txt
# Test the grammar on all sample files.
./checkAllDescriptions.sh
```

### Generating the parser

If you modify `FirestoreRules.g4`, you may want to regenerate the parser:

```sh
cd grammar
./regenerateParser.sh
```
