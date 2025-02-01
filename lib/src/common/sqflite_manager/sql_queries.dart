import 'package:bloc_clean_architecture/src/common/sqflite_manager/tables/todo_table.dart';

class SqlQueries {
  static String createTableTodos = '''
      CREATE TABLE ${TodoTable.tableName} (
      ${TodoTable.idFieldName} INTEGER, 
      ${TodoTable.titleFieldName} TEXT,
      ${TodoTable.descriptionFieldName} TEXT,
      ${TodoTable.dateTimeFieldName} DATETIME,
      ${TodoTable.isSelectedFieldName} INTEGER,
      PRIMARY KEY("${TodoTable.idFieldName}" AUTOINCREMENT)
    );
  ''';

  //static String migration2SelectAllTableName = 'update ${TodoTable.tableName} set ${TodoTable.title} = ' ', ${TodoTable.dateTime} = NULL;';
}
