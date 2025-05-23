import 'package:emart_app/consts/consts.dart';

Widget featureButton({String? title, icon}){
  return Row(
    children: [
      Image.asset(icon,width: 30,fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).size(14.0).color(darkFontGrey).make(),
    ],
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).padding(EdgeInsets.all(4)).outerShadowSm.make();
}