import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shaqo_plus/screens/home_screen.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/reusbale_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/onboard animation.json",
                width: size.width * 1000,
                height: size.height * .45,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Finding Your ',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'Perfect Career',
                      style: GoogleFonts.inter(
                        color: primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: ' \nPath Starts Here!',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "In publishing and graphic design, Lorem \nipsum is a placeholder text commonly used to  ",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: greyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ReUsableBtn(
                btnText: "Let's Get Started",
                ontap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("onBoard", true);
                },
              ),
              const SizedBox(
                height: 20,
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
                  Text(
                    "Sign in",
                    style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
