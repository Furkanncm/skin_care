import 'package:bloc_clean_architecture/src/common/sqflite_manager/sqflite_db_migration.dart';
import 'package:bloc_clean_architecture/src/common/sqflite_manager/sql_queries.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

@singleton
final class SqfliteManager extends CoreSqfliteManager {
  SqfliteManager() : super(version: 1);

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(SqlQueries.createTableTodos);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    /*
        MIGRATION İŞLEMLERİ

        Uygulama yeni yüklendiyse ve Depolamadan veriler silindiyse onCreate metotu tetikleniyor sonrasında burası hiçbirzaman tetiklenmiyor.
        Uygulama zaten yüklüyse versiyon arttırıldığı durumda onUpgrade tetikleniyor.

        *** Yeni tablo ekleniyorsa hem onCreate hem de onUpgrade'e sql komutu eklenmeli.
        *** Tablo silinecekse onCreate'den sql komutu silinmeli, onUpgrade'e drop komutu yazılmalı.
        *** Mevcut tablo güncelleniyorsa onCreate'deki sql komutu güncellenmeli, onUpgrade'e alter komutu yazılmalı.
    */

    // Migration'lar set ediliyor
    Migration.setMigrations(db);

    // Eski versiyondan güncel versiyona kadar olan tüm migration'lar çalıştırılıyor.
    for (var i = oldVersion + 1; i <= newVersion; i++) {
      final migration = Migration.migrations.firstWhere((element) => element.version == i);
      await migration.execute();
    }
  }
}
