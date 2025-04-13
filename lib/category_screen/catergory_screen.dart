
import 'package:emart_app/consts/lists.dart';

import '../consts/consts.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make Scaffold transparent
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent, // Make AppBar transparent
          automaticallyImplyLeading: false,
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
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
                    Image.asset(categoriesImages[index], height: 130, width: context.width, fit: BoxFit.fill),
                    30.heightBox,
                    "${categoriesList[index]}".text.color(darkFontGrey).fontFamily(semibold).align(TextAlign.center).make(),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make();
              },
            ),
          ),
      ),
    );
  }
}
