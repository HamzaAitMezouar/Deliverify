import 'package:deliverify/src/models/order_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrdersSqlite {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'order.db');
    Database database =
        await openDatabase(path, onCreate: onCreate, version: 1);
    return database;
  }

  onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "order" (
  "id" INTEGER  PRIMARY KEY AUTOINCREMENT,
  "itemname" TEXT,
  "itemprice" REAL,
  "itemcount" INTEGER,
  "username" TEXT
)
''');
    print('TAABLE ORDER CREATEED--------------');
  }

  insert(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    print(response);
    return response;
  }

  Future<List<Map>> read(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    print(response);
    //late List<OrderModel> list;
    //list = response.map((e) => OrderModel.fromJson(e)).toList();
    // print(list);

    return response;
  }

  delete(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    print(response);
    return response;
  }
}
