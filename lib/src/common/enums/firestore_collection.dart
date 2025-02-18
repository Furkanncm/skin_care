enum FirestoreCollection {
  users('users'),
  cosmetics('cosmetics'),
  plans('plans'),
  morning('morning'),
  evening('evening');

  final String value;

  const FirestoreCollection(this.value);
}
