import 'dart:convert';
import 'dart:ui';

import 'package:emart_app/category_screen/Product.dart';
import 'package:emart_app/category_screen/ProductCategory.dart';
import 'package:emart_app/category_screen/item_details.dart';
import 'package:emart_app/consts/consts.dart';
import '../widgets_common/bg_widget.dart';
import 'package:http/http.dart' as http;

class CategoryDetails extends StatefulWidget {
  final String? title;
  final String? categoryname;

  CategoryDetails(
      {Key? key, required this.title, required this.categoryname})
      : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}
class _CategoryDetailsState extends State<CategoryDetails>{
  List<Product> filteredProducts=[];
  @override
  void initState() {
    super.initState();
    getFilteredProducts();
  }
  Future<void> getFilteredProducts()async{
    final url=Uri.parse("http://localhost:8080/api/product/categories?categoryname=${widget.categoryname}");
    try {
      final response = await http.get(
        url,
      );
      if(response.statusCode==200||response.statusCode==201){
        List<dynamic> jsonData=jsonDecode(response.body);
        setState(() {
          filteredProducts=jsonData.map((item)=>Product.fromJson(item)).toList();
        });
        print("Requesting products for: ${widget.categoryname}");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Products Found")));
      }
    }catch(e){print("error: $e");}
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController _horizontalScrollController = ScrollController();
    final ScrollController _verticalScrollController = ScrollController();

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // Horizontal Scroll Row
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                  },
                ),
                child: Scrollbar(
                  controller: _horizontalScrollController,
                  thumbVisibility: true,
                  interactive: true,
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(
                        6,
                            (index) => "Clothing"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .rounded
                            .size(120, 60)
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .make(),
                      ),
                    ),
                  ),
                ),
              ),
              10.heightBox,

              // Vertical Grid Scroll
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                      },
                    ),
                    child: Scrollbar(
                      controller: _verticalScrollController,
                      thumbVisibility: true,
                      interactive: true,
                      child: GridView.builder(
                        controller: _verticalScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final product=filteredProducts[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                product.imgurl,
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace){
                                  return const Icon(Icons.broken_image,size: 100,color: Colors.grey,);
                                },
                              ),
                              product.productname
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "₹${product.productprice}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                              10.heightBox,
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make().onTap((){
                            Get.to(() => ItemDetails(title: product.productname));
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}