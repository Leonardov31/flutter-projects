import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database db;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'shopping.db'),
        onCreate: (database, version) {
          database.execute(
            'CREATE TABLE lists(id INTEGER PRIMARY KEY, nmae TEXT, priority INTEGER)',
          );
          database.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, nmae TEXT, quantity TEXT, note TEXT, ' +
                'FOREIGN KEY(idList) REFERENCES lists(id))',
          );
        },
        version: version,
      );
    }

    return db;
  }

  Future testDb() async {
    db = await openDb();
    await db.execute('INSERT INTO lists VALUES (2, "Fruit", 2)');
    await db.execute(
        'INSERT INTO items VALUES (2, 2, "Apples", "2 KG", "Better if they are green")');
    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists[2].toString());
    print(items[2].toString());
  }
}
