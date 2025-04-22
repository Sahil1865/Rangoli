import 'dart:convert';
import 'dart:ui';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/home_screen/Product.dart';
import 'package:emart_app/home_screen/components/feature_button.dart';
import 'package:emart_app/widgets_common/home_buttons.dart';
import '../consts/consts.dart';
import 'package:http/http.dart' as http;

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({Key? key}) : super(key: key);

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}
class _HomeContentPageState extends State<HomeContentPage>{
  final ScrollController _verticalScrollController = ScrollController();
  List<Product> products=[];
  bool isLoading=true;

  @override
  void initState(){
    super.initState();
    fetchProducts();
  }
  Future<void> fetchProducts()async{
    try{
      final response=await http.get(
        Uri.parse("http://localhost:8080/api/products"),
      );
      if(response.statusCode==200||response.statusCode==201){
        final List<dynamic> jsonData=jsonDecode(response.body);
        setState(() {
          products=jsonData.map((item)=>Product.fromJson(item)).toList();
          isLoading=false;
        });
      }else{
        throw Exception("Failed to load products");
      }
    }catch(e){print("error fetching products: $e");
    setState(() {
      isLoading=false;
    });}
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
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
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Swiper 1
                        VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration: 5.seconds,
                          itemCount: slidersList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.asset(
                                slidersList[index],
                                fit: BoxFit.fill,
                              ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make(),
                            );
                          },
                        ),
                        10.heightBox,

                        // Deals Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(2, (index) =>
                              Flexible(
                                child: homeButtons(
                                  height: context.screenHeight * 0.12,
                                  width: double.infinity, // Take available width
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashsale,
                                ),
                              ),
                          ),
                        ),
                        10.heightBox,

                        // Swiper 2
                        VxSwiper.builder(
                          aspectRatio: 21 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration: 5.seconds,
                          itemCount: slidersList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: FittedBox(
                                child: Image.asset(
                                  secondSlidersList[index],
                                  fit: BoxFit.fill,
                                ),
                              ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make(),
                            );
                          },
                        ),
                        10.heightBox,

                        // Buttons below swiper 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(3, (index) => homeButtons(
                            height: context.screenHeight * 0.12,
                            width: context.screenWidth / 3.5,
                            icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                            title: index == 0 ? topCategories : index == 1 ? brands : topSellers,
                          )),
                        ),

                        // Featured Categories
                        10.heightBox,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text.color(darkFontGrey).size(22).fontFamily(semibold).make(),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(3, (index) => Column(
                              children: [
                                featureButton(icon: featuredImgList1[index], title: featuredTitlesList1[index]),
                                10.heightBox,
                                featureButton(icon: featuredImgList2[index], title: featuredTitlesList2[index]),
                              ],
                            )).toList(),
                          ),
                        ),

                        // All Products Section
                        20.heightBox,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: allproducts.text.color(darkFontGrey).size(22).fontFamily(semibold).make(),
                        ),
                        10.heightBox,
                        isLoading
                          ?const CircularProgressIndicator():
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(), // Don't scroll inside
                          shrinkWrap: true,
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 300,
                          ),
                          itemBuilder: (context, index) {
                            final product=products[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  product.imgurl,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                product.productname.text.fontFamily(semibold).size(16).color(darkFontGrey).make(),
                                10.heightBox,
                                "₹${product.productprice}".text.color(redColor).fontFamily(bold).size(16).make(),
                                10.heightBox,
                              ],
                            ).box.gray100.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
