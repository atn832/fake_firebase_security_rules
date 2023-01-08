extension Includes on List<Method> {
  bool includes(Method method) => any((m) => m.includes(method));
}

/// Based on https://firebase.google.com/docs/rules/rules-language#method.
enum Method {
  read('read', {Method.list}),
  write('write', {Method.update, Method.delete}),
  update('update'),
  delete('delete'),
  list('list');

  const Method(this.nameInFirebase, [this.alsoIncludes = const {}]);

  final String nameInFirebase;
  final Set<Method> alsoIncludes;

  bool includes(Method m) {
    return m == this || alsoIncludes.contains(m);
  }

  factory Method.fromNameInFirebase(String nameInFirebase) {
    return Method.values
        .firstWhere((method) => method.nameInFirebase == nameInFirebase);
  }
}
