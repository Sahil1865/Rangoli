import 'package:emart_app/category_screen/ProductCategory.dart';

class Product {
  final int productID;
  final String productname;
  final String imgurl;
  final String productprice;
  final List<String> categorynames;

  Product({
    required this.productID,
    required this.productname,
    required this.imgurl,
    required this.productprice,
    required this.categorynames,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['productID'],
      productname: json['productname'],
      imgurl: json['imgurl'],
      productprice: json['productprice'],
      categorynames: List<String>.from(json['categorynames']),
    );
  }
}