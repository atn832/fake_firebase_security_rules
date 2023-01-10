# fake_firebase_security_rules

[![pub package](https://img.shields.io/pub/v/fake_firebase_security_rules.svg)](https://pub.dartlang.org/packages/fake_firebase_security_rules)
[![Tests](https://github.com/atn832/fake_firebase_security_rules/actions/workflows/dart.yml/badge.svg)](https://github.com/atn832/fake_firebase_security_rules/actions/workflows/dart.yml)

This project simulates [Firebase Security Rules](https://firebase.google.com/docs/rules). It is meant to be used by [Fake Cloud Firestore](https://pub.dev/packages/fake_cloud_firestore) and [Firebase Storage Mocks](https://pub.dev/packages/firebase_storage_mocks). Given these request inputs:

* Firebase security rules such as:

```
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

* Concrete path, access method, eg an `update` on `/databases/some-db/users/abcd`,
* Variables, eg a `Map` such as `{'request': { 'auth': { 'uid': 'efgh' } } }`,

the library computes whether the request should be allowed or not.

## Usage

```dart
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
```

See the [Unit tests](https://github.com/atn832/fake_firebase_security_rules/blob/main/test/firestore_rules_test.dart) for more advanced examples of usage.

## Features

Supports:

* rules declarations used in Firestore and Firebase Storage.
* recursive `match` definitions.
* exhaustive path matching with path variables and wildcards, eg `/users/{userId}/{documents=**}`.
* `request.auth` object populated with uid, custom claims...
* standard CEL types and methods, eg `bool`, `int`, `double`, `String`, `Map`, `List`, `String.match(regexp)`, `a in list`... See [cel-dart's supported features](https://pub.dev/packages/cel#features) for an exhaustive list.

Missing:

* timestamps.
* durations.
* custom functions.
* `resource` object.
* `request.resource` object.
* `exists()`, `get()` functions.

## Implementation details

### Differences between Firebase Rules CEL and standard CEL

* Timestamps. Although not implemented in this project yet, Firebase Rules uses its own [Timestamp](https://firebase.google.com/docs/reference/rules/rules.Timestamp) implementation while CEL uses `google.protobuf.Timestamp` ([spec](https://github.com/google/cel-spec/blob/master/doc/langdef.md#abstract-types)).

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
