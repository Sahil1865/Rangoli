import 'dart:core';

class ProductCategory{
  final int productID;
  final int categoryID;

  ProductCategory({
    required this.productID,
    required this.categoryID
});
  factory ProductCategory.fromJson(Map<String,dynamic> json){
    return ProductCategory(productID: json['productID'], categoryID: json['categoryID']);
  }
}