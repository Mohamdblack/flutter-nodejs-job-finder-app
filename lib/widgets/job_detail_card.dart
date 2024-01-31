import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shaqo_plus/themes/colors.dart';

class JobDetailCard extends StatefulWidget {
  const JobDetailCard({
    super.key,
    required this.iconName,
    required this.titleName,
    required this.descName,
  });
  final IconData iconName;
  final String titleName;
  final String descName;

  @override
  State<JobDetailCard> createState() => _JobDetailCardState();
}

class _JobDetailCardState extends State<JobDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 233, 233),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              widget.iconName,
              color: primaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.titleName,
                style: GoogleFonts.inter(
                  color: greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                widget.descName,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
