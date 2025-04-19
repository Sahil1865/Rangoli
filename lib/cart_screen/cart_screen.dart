import '../consts/consts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: "Cart is Empty!".text.fontFamily(semibold).color(darkFontGrey).makeCentered(),
    );
  }
}