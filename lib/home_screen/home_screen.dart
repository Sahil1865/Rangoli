import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/home_screen/components/feature_button.dart';
import 'package:emart_app/widgets_common/home_buttons.dart';

import '../consts/consts.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: SafeArea(
          child: Column(
            children: [
              //swiper brands
          Expanded(
          child:  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: 5.seconds,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image
                              .asset(
                            slidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 8))
                              .make(),
                        );
                      }
                  ),
                  10.heightBox,
                  //deals button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(2, (index) =>
                        homeButtons(
                          height: context.screenHeight * 0.12,
                          width: context.screenWidth/2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashsale,
                        )),
                  ),
                  10.heightBox,
                  //swiper
                  VxSwiper.builder(
                      aspectRatio:  21 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: 5.seconds,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: FittedBox(
                              child: Image
                                  .asset(
                                secondSlidersList[index],
                                fit: BoxFit.fill,
                              )
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 8))
                              .make(),
                        );
                      }
                  ),
                  10.heightBox,
                  // buttons below swiper 2
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(3, (index) => homeButtons(
                        height: context.screenHeight * 0.12,
                        width: context.screenWidth/ 3.5,
                        icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                        title: index == 0 ? topCategories : index == 1 ? brands : topSellers,
                      ))
                  ),

                  //featured categories
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text.color(darkFontGrey).size(22).fontFamily(semibold).make(),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:  List.generate(3, (index) => Column(
                        children: [
                          featureButton(icon: featuredImgList1[index], title: featuredTitlesList1[index]),
                          10.heightBox,
                          featureButton(icon: featuredImgList2[index], title: featuredTitlesList2[index]),
                        ],
                      )
                      ).toList(),
                    ),
                  ),


                  //all products section
                  20.heightBox,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, mainAxisExtent: 300),
                      itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  imgP5,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "₹30,000".text.color(redColor).fontFamily(bold).size(16).make(),
                                10.heightBox,
                              ],
                            ).box.gray100.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make();
                      }
                  )
                ],
              )
              )
            ),
            ],
          )
      ),
    );
  }
}