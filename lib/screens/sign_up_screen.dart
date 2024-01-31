import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shaqo_plus/screens/sign_in_screen.dart';
import 'package:shaqo_plus/services/auth_services.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/widgets/reusbale_button.dart';

class SignUnScreen extends StatefulWidget {
  const SignUnScreen({super.key});

  @override
  State<SignUnScreen> createState() => _SignUnScreenState();
}

class _SignUnScreenState extends State<SignUnScreen> {
  bool isHidden = true;

  AuthServices authServices = AuthServices();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void signUpUser() {
    authServices.signUpUser(
      context: context,
      companyName: _companyNameController.text,
      email: _emailController.text,
      password: _passController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _companyNameController.dispose();
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
                  Center(
                    child: Text(
                      "Create an account ",
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
                    "Fill your infromation below and \nthen enter your credentials ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: greyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _companyNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "company/person name",
                      prefixIcon: Icon(
                        Icons.person_2,
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
                    children: [
                      Checkbox(
                        activeColor: primaryColor,
                        value: true,
                        onChanged: (value) {},
                      ),
                      Text(
                        "Agree with",
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Terms & Conditions",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ReUsableBtn(
                    ontap: () {
                      signUpUser();
                    },
                    btnText: "Sign up",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
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
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
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
