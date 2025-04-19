import 'package:emart_app/account_screen/components/details_card.dart';
import 'package:emart_app/consts/lists.dart';

import '../consts/consts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: SafeArea(child: Column(
          children: [

            //edit profile button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Align(
                  alignment: Alignment.topRight,
                  child:Icon(Icons.edit,color: whiteColor)),
            ),
            //user details section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Image.asset(imgProfile,width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.widthBox,
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    "Dummy User".text.fontFamily(semibold).white.make(),
                    "customer@example.com".text.white.make(),
                  ],)),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: whiteColor,
                      )
                    ),
                      onPressed: (){}, child: logout.text.fontFamily(semibold).white.make())

                ],
              ),
            ),

            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsCard(count: "00",title: "in your cart",width: context.screenWidth/3.4),
                detailsCard(count: "32",title: "in your wishlist",width: context.screenWidth/3.4),
                detailsCard(count: "675",title: "your orders",width: context.screenWidth/3.4),
              ],
            ),

            //buttons

            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(color: lightGrey);
              },
              itemCount: profileButtonsList.length,
              itemBuilder: (BuildContext context,int index){
                return ListTile(
                  leading: Image.asset(profileButtonsIcon[index],width: 22,),
                  title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                );
              },
            ).box.white.margin(EdgeInsets.all(12)).rounded.padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.make(),
          ],
        )),
      ),
    );
  }
}
