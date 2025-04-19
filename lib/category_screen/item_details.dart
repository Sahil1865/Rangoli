import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/gestures.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: darkFontGrey)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite, color: darkFontGrey)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  interactive: true,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Swiper
                        VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          itemCount: 3,
                          aspectRatio: 16 / 9,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              imgFc2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        10.heightBox,
                        title!.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                        10.heightBox,
                        VxRating(
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          stepInt: true,
                        ),
                        10.heightBox,
                        "\$400".text.color(redColor).fontFamily(bold).size(18).make(),
                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Seller".text.white.fontFamily(semibold).make(),
                                  5.heightBox,
                                  "Rangoli Book Depo"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make(),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded, color: darkFontGrey),
                            ),
                          ],
                        ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),
                        20.heightBox,

                        // Color, quantity, total
                        Column(
                          children: [
                            // Color row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color: ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                    3,
                                        (index) => VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Vx.randomPrimaryColor)
                                        .margin(const EdgeInsets.symmetric(horizontal: 6))
                                        .make(),
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            // Quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
                                    "0".text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(0 available)".text.color(textfieldGrey).make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            // Total
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: ".text.color(textfieldGrey).make(),
                                ),
                                "\$0.00".text.color(redColor).size(16).fontFamily(bold).make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),

                        // Description
                        10.heightBox,
                        "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        "This is a dummy item with a dummy description..."
                            .text
                            .color(darkFontGrey)
                            .make(),

                        // Buttons List
                        10.heightBox,
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            itemDetailButtonsList.length,
                                (index) => ListTile(
                              title: "${itemDetailButtonsList[index]}"
                                  .text
                                  .semiBold
                                  .color(darkFontGrey)
                                  .make(),
                              trailing: Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Add to Cart button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              color: redColor,
              onPress: () {},
              textColor: whiteColor,
              title: "Add to Cart",
            ),
          ),
        ],
      ),
    );
  }
}
