import 'dart:ui';

import 'package:emart_app/category_screen/item_details.dart';
import 'package:emart_app/consts/consts.dart';
import '../widgets_common/bg_widget.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _horizontalScrollController = ScrollController();
    final ScrollController _verticalScrollController = ScrollController(); // ✅ separate

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: title!.text.fontFamily(bold).white.make(),
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
                  controller: _horizontalScrollController, // ✅ new controller
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
                      controller: _verticalScrollController, // ✅ new controller
                      thumbVisibility: true,
                      interactive: true,
                      child: GridView.builder(
                        controller: _verticalScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                imgP5,
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              "Laptop 4GB/64GB"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "₹30,000"
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
                            Get.to(() =>
                            const ItemDetails(title: "Dummy title"));
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