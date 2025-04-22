import 'dart:convert';

import 'package:emart_app/account_screen/components/details_card.dart';
import 'package:emart_app/auth_screen/login_screen.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../consts/consts.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}
class _AccountScreenState extends State<AccountPage>{
  Map<String,dynamic>? userData;
  String? userName="Loading";
  String? userEmail="Loading";
  @override
  void initState(){
    super.initState();
    User? accountUser=FirebaseAuth.instance.currentUser;
    String? email=accountUser?.email;
    if(email!=null){
      loadUserData(email);
    }
  }

  Future<Map<String,dynamic>?> loadUserData(String email) async{
    final url=Uri.parse("http://localhost:8080/api/account?email=$email");
    final response=await http.get(
      url,
      headers: {"Content-Type":"application/json"},
    );
    if(response.statusCode==200){
      print("Fetching user data for email: $email");
      final data=jsonDecode(response.body);
      setState(() {
        userData=data;
        userName=data['username'];
        userEmail=data['email'];
      });
    }else{
      print("Failed to load data: ${response.body}");
    }
  }

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
                  Image.asset(defaultimg,width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.widthBox,
                  Expanded(
                      child:userData==null?"Loading...".text.white.make()
                      :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            userName!.text.fontFamily(semibold).white.make(),
                            userEmail!.text.white.make(),
                        ],)),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: whiteColor,
                      )
                    ),
                      onPressed: ()async{
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: logout.text.fontFamily(semibold).white.make())

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

