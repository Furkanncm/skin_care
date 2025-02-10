enum FirestoreCollection {
  users('users'),
  cosmetics('cosmetics'),
  plans('plans');

  final String value;

  const FirestoreCollection(this.value);
}
