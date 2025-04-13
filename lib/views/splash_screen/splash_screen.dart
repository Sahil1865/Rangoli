import 'package:emart_app/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/consts/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //creating a method to change the screen

  changeScreen(){
    Future.delayed(const Duration(seconds: 3),() {
      //using getx
      Get.to(()=> const LoginScreen());
    });
  }

  @override
  void initState(){
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft, child: Image.asset(icSplashBg,width: 300,)),
              20.heightBox,
              applogoWidget(),
              15.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              10.heightBox,
              appversion.text.white.make(),
              const Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
          ],
        ),
      ),
    );
  }
}