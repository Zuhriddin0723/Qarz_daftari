import '../database/database_helped.dart';
import '../model/product_model.dart';

class RepositoryProduct{
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  Future<int> saveProduct(data) => dataBaseHelper.saveProduct(data);
  Future<int> updateBase(data) => dataBaseHelper.updateBase(data);
  Future<int> deleteBaseProduct(id)async => await dataBaseHelper.deleteBaseProduct(id);
  Future<List<ProductModel>> getContact() => dataBaseHelper.malumotlarniolishProduct();
  Future<List<ProductModel>> malumotlarniolishsearch(q) => dataBaseHelper.malumotlarniolishsearch(q);

}