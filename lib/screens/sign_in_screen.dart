import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shaqo_plus/screens/sign_up_screen.dart';
import 'package:shaqo_plus/services/auth_services.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/widgets/reusbale_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isHidden = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  AuthServices authServices = AuthServices();

  void signInUser() {
    authServices.signInUser(
        context: context,
        email: _emailController.text,
        password: _passController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/login.png"),
                  Center(
                    child: Text(
                      "ShaqoPlus+",
                      style: GoogleFonts.courgette(
                        fontSize: 45,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Hi! Welcome back, you've been missed",
                    style: GoogleFonts.inter(
                      color: greyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "example@gmail.com",
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: primaryColor,
                      ),
                      hintStyle: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _passController,
                    obscureText: isHidden,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: greyColor,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: primaryColor,
                        ),
                      ),
                      hintText: "****************",
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        child: Icon(
                          isHidden == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: primaryColor,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.inter(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: primaryColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ReUsableBtn(
                    ontap: () {
                      signInUser();
                    },
                    btnText: "Sign in",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.inter(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: greyColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUnScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.inter(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
