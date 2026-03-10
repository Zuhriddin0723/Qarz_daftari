import 'package:rxdart/rxdart.dart';

import '../model/product_model.dart';
import '../repository/repository_product.dart';

class ContactBlocProduct{
  RepositoryProduct repositoryWallet = RepositoryProduct();
  final _fetchContactInfo = PublishSubject<List<ProductModel>>();
  Stream<List<ProductModel>> get getStreamProduct => _fetchContactInfo.stream;

  getAllName()async{
    List<ProductModel> data = await repositoryWallet.getContact();
    _fetchContactInfo.sink.add(data);
  }
  getAllNameSearch(q)async{
    List<ProductModel> data = await repositoryWallet.malumotlarniolishsearch(q);
    _fetchContactInfo.sink.add(data);
  }
}
ContactBlocProduct contactBlocProduct = ContactBlocProduct();