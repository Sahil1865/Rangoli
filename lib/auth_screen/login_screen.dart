import 'dart:convert';

import 'package:emart_app/auth_screen/signup_screen.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/home_screen/home.dart';
import 'package:emart_app/home_screen/home_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen>{
  @override
  dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  Future<void>LoginUser()async{
    if(emailController.text.trim().isEmpty||passwordController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill The Text Fields!"),));
    }
    final url=Uri.parse("http://localhost:8080/api/login");
    try{
      final response=await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "email":emailController.text.trim(),
          "password":passwordController.text.trim(),
        }),
      );
      if(response.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful!")));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect Email or Password")));
      }
    }catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed To Login: $e"),));}
  }

  Future<void> signInWithFacebook()async{
    try{
      final LoginResult result=await FacebookAuth.instance.login();
      if(result.status==LoginStatus.success){
        final OAuthCredential facebookAuthCredential=FacebookAuthProvider.credential(result.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Facebook Login Successful!")));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }else{
        print("Facebook login status: ${result.status}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Facebook Login Failed!")));
      }
    }catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));}
  }

  Future<UserCredential> signInWithGoogle()async{
    final GoogleSignIn googleSignIn=new GoogleSignIn(clientId: "911543359195-9fjnh5cp2tspg5fm3ec1k882fkmeuhrt.apps.googleusercontent.com");
    final GoogleSignInAccount? googleUser=await googleSignIn.signIn();
    if(googleUser==null){
      throw FirebaseAuthException(code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
    }
    final GoogleSignInAuthentication googleAuth=await googleUser.authentication;
    final OAuthCredential credential=GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_checkout, size: 100, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  "RANGOLI",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 15),
                _buildInputField(icon: Icons.email_outlined, hintText: 'EMAIL', controller: emailController),
                const SizedBox(height: 15),
                _buildInputField(icon: Icons.lock_outline, hintText: 'PASSWORD', isPassword: true, controller: passwordController),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Login Button -> Navigate to Home Screen
                _buildButton(
                  text: 'LOGIN',
                  backgroundColor: Colors.white,
                  textColor: Colors.blue[900] ?? Colors.blue,
                  onPressed: LoginUser,
                ),
                const SizedBox(height: 15),

                const Text(
                  "or, create a new account",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 15),

                _buildButton(
                  text: 'NEW ACCOUNT? REGISTER',
                  backgroundColor: Colors.blue[700] ?? Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Get.to(() => const RegisterScreen());
                  },
                ),
                5.heightBox,
                const Text(
                  "or login with",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(1, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async{
                        if(index==0){
                          try{
                            await signInWithGoogle();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign In With Google Successful!"),));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()),);
                          }catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : $e")));}
                        }else{
                          try{
                            await signInWithFacebook();
                          }catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));}
                        }
                      },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 25,
                          child: Image.asset(socialIconList[index],
                              width: 30),
                        )),
                    ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white24,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}