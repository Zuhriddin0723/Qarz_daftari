import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/product_model.dart';

class DataBaseHelper {
  static final DataBaseHelper _dataBaseHelper = DataBaseHelper._init();

  factory DataBaseHelper() => _dataBaseHelper;
  static Database? _db;

  DataBaseHelper._init();

  Future<Database> get AsosiyDB async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();

    return _db!;
  }

  _initDb() async {
    /// Bazani yo'lni oladi
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'walletlist.db');
    print(dataBasePath);
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE product('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'price REAL,'
        'number REAL'
        ')');

  }
  //Wallet

  Future<int> saveProduct(ProductModel item) async {
    var dbClient = await AsosiyDB;
    var result =  dbClient.insert('product', item.toJson());
    print("object:${result}");
    return result;
  }

  Future<List<ProductModel>> malumotlarniolishProduct() async {
    var dbClient = await AsosiyDB;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM product');
    List<ProductModel> data = [];
    for (int i = 0; i < list.length; i++) {
      ProductModel contactModel = ProductModel(
          id: list[i] ["id"],
          name: list[i] ["name"],
          price: list[i] ["price"],
          number: list[i] ["number"],
      );
      data.add(contactModel);
    }
    return data;
  }
  Future<List<ProductModel>> malumotlarniolishsearch(q) async {
    var dbClient = await AsosiyDB;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM product WHERE name LIKE '%$q%'");
    List<ProductModel> data = [];
    for (int i = 0; i < list.length; i++) {
      ProductModel contactModel = ProductModel(
          id: list[i] ["id"],
          name: list[i] ["name"],
          price: list[i] ["price"],
          number: list[i] ["number"],
      );
      data.add(contactModel);
    }
    return data;
  }
  Future<int> deleteBaseProduct(id)async{
    var db = await AsosiyDB;
    print("delete");
    print(id);
    return await db.delete('product',where: 'id = ?' ,whereArgs: [id]);
  }

//InCome



//
Future<int> updateBase(ProductModel item)async{
  var db = await AsosiyDB;
  var res = db.update('product', item.toJson(),where: 'id = ?' ,whereArgs: [item.id]);
  return res;
}
}