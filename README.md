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

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
