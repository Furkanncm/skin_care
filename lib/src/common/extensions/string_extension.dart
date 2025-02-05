extension StringExtension on String {
  String splitName( ) {
    return this.splitMapJoin(
      RegExp(r'[A-Z]'),
      onMatch: (m) => ' ${m.group(0)}',
      onNonMatch: (m) => m,
    );
    
  }
}