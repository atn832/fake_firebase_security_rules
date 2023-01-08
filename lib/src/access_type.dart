extension Includes on List<AccessType> {
  /// In theory, it should also support `read.includes(update) ==> true`. See
  /// https://firebase.google.com/docs/rules/rules-language#method.
  bool includes(AccessType accessType) {
    return contains(accessType);
  }
}

enum AccessType {
  read('read'),
  write('write'),
  update('update'),
  delete('delete'),
  list('list');

  const AccessType(this.nameInFirebase);
  final String nameInFirebase;

  factory AccessType.fromNameInFirebase(String nameInFirebase) {
    return AccessType.values.firstWhere(
        (accessType) => accessType.nameInFirebase == nameInFirebase);
  }
}
