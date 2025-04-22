class Product{
  final int productID;
  final String productname;
  final String imgurl;
  final String productprice;

  Product({
    required this.productID,
    required this.productname,
    required this.imgurl,
    required this.productprice
});
  factory Product.fromJson(Map<String,dynamic> json){
    return Product(productID: json['productID'], productname: json['productname'], imgurl: json['imgurl'], productprice: json['productprice']);
  }
}