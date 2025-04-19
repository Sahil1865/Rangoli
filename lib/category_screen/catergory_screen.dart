import 'dart:ui';
import 'package:emart_app/category_screen/category_details.dart';
import 'package:emart_app/consts/lists.dart';
import '../consts/consts.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              interactive: true,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        categoriesImages[index],
                        height: 130,
                        width: context.width,
                        fit: BoxFit.fill,
                      ),
                      30.heightBox,
                      "${categoriesList[index]}"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .align(TextAlign.center)
                          .make(),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .clip(Clip.antiAlias)
                      .outerShadowSm
                      .make()
                      .onTap(() {
                    Get.to(() => CategoryDetails(title: categoriesList[index]));
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
