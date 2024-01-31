import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class ReUsableBtn extends StatelessWidget {
  const ReUsableBtn({
    required this.ontap,
    required this.btnText,
    super.key,
  });
  final String btnText;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          btnText,
          style: GoogleFonts.inter(
            color: whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        )),
      ),
    );
  }
}
