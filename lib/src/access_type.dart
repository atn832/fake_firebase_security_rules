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
