import 'package:emart_app/consts/consts.dart';

Widget homeButtons({height, width, icon, String? title, onPress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 26,),
        10.heightBox,
        title!.text.fontFamily(semibold).size(14.0).color(darkFontGrey).make()
      ],
    ).box.rounded.white.size(width, height).shadow.make();
}
