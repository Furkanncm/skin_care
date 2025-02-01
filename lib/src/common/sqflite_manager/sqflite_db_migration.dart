import 'package:flutter_core/flutter_core.dart';

class Migration {
  Migration({required this.version, required this.execute});
  int version;
  Future<void> Function() execute;
  static late List<Migration> migrations;

  static void setMigrations(Database database) {
    migrations = [
      /* Migration(
        version: 2,
        execute: () async {
          await database.execute(SqlQueries.migration2SelectAllTableName);
        },
      ), */
    ];
  }
}
