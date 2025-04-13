import '../consts/consts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool? isCheck=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Icon(Icons.shopping_cart_checkout, size: 100, color: Colors.white),
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
                20.heightBox,
    Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.2), // Slight transparency
    borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
    children: [
                const Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Input fields
                _buildInputField(icon: Icons.person_outline, hintText: "NAME"),
                const SizedBox(height: 15),
                _buildInputField(icon: Icons.email_outlined, hintText: "EMAIL"),
                const SizedBox(height: 15),
                _buildInputField(icon: Icons.phone_outlined, hintText: "PHONE NUMBER"),
                const SizedBox(height: 15),
                _buildInputField(icon: Icons.lock_outline, hintText: "PASSWORD", isPassword: true),
                const SizedBox(height: 20),
                _buildInputField(icon: Icons.lock_outline, hintText: "RETYPE PASSWORD", isPassword: true),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                        checkColor: Colors.red,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(text: const TextSpan(
                        children: [
                          TextSpan(text: "I agree to the ",
                            style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                          TextSpan(
                            text: termsAndCond,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,

                            )
                          ),
                          TextSpan(
                              text: "&",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )
                          ),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: bold,
                                color: redColor,

                              )
                          ),
                        ],
                    )),
                    )
                  ],
                ),
                // Register Button
                _buildButton(text: "REGISTER", onPressed: () {}),
              ],
            ),
          ),
        ],
        ),
      ),
      ),
      ),
    );
  }

  Widget _buildInputField({required IconData icon, required String hintText, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isCheck == true? redColor : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }
}