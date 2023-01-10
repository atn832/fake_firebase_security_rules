/// Based on https://firebase.google.com/docs/rules/rules-language#method.
enum Method {
  read('read', alsoIncludes: {Method.list}),
  write('write', alsoIncludes: {Method.update, Method.delete}),
  update('update'),
  delete('delete'),
  list('list');

  const Method(this.nameInFirebase, {this.alsoIncludes = const {}});

  final String nameInFirebase;
  final Set<Method> alsoIncludes;

  /// Returns whether a method encompasses the given method. For example `write`
  /// not only includes itself, but also includes `list` and `delete`.
  bool includes(Method m) {
    return m == this || alsoIncludes.contains(m);
  }

  factory Method.fromNameInFirebase(String nameInFirebase) {
    return Method.values
        .firstWhere((method) => method.nameInFirebase == nameInFirebase);
  }
}
