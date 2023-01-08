extension Includes on List<Method> {
  /// In theory, it should also support `read.includes(update) ==> true`. See
  /// https://firebase.google.com/docs/rules/rules-language#method.
  bool includes(Method method) {
    return contains(method);
  }
}

enum Method {
  read('read'),
  write('write'),
  update('update'),
  delete('delete'),
  list('list');

  const Method(this.nameInFirebase);
  final String nameInFirebase;

  factory Method.fromNameInFirebase(String nameInFirebase) {
    return Method.values
        .firstWhere((method) => method.nameInFirebase == nameInFirebase);
  }
}
