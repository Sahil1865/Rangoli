import 'package:emart_app/consts/consts.dart';

Widget ourButton({
  Color? color,
  VoidCallback? onPress,
  Color? textColor,
  String? title,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? Colors.transparent,
      elevation: 0, // Optional: remove shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // less rounded
      ),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
