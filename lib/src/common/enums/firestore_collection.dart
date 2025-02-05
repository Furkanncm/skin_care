enum FirestoreCollection {
  users('users'),
  cosmetics('cosmetics');

  final String value;

  const FirestoreCollection(this.value);
}
