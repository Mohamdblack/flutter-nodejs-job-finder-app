import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReUsableJobType extends StatelessWidget {
  const ReUsableJobType({
    required this.jobType,
    super.key,
  });
  final String jobType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        jobType,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
