import 'dart:convert';

ProductModel welcomeFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String welcomeToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int id;
  String name;
  double price;
  int number;

  ProductModel({
    this.id = 0,
    required this.name,
    required this.price,
    required this.number,
  });

  /// JSONdan o‘qish
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? 0,
    name: json["name"]??"",
    price: json["price"]??0,
    number: json["number"]??0,
  );

  /// JSONga yozish
  Map<String, dynamic> toJson() => {
    // "id": id,
    "name": name,
    "price": price,
    "number": number,
  };
}
