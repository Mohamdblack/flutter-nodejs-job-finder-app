import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shaqo_plus/screens/search_screen.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/widgets/reusable_main_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List rondomApplicants = [
    "https://media.istockphoto.com/id/1449171785/photo/young-it-specialist-working-at-pc-at-home-debugging-java-script-cyber-space-error.jpg?s=2048x2048&w=is&k=20&c=Rdz13C792Muqpnz6Ejc5uNTWzWsjTTq1EZNMZINTl3Q=",
    "https://images.unsplash.com/photo-1542546068979-b6affb46ea8f?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1538652116325-8f5fa30fefff?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1539083937338-70c0c67c3ecd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final jobs = Provider.of<JobProvider>(context).jobs;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: size.height * .03,
                  bottom: size.height * .04),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    // height: 120,
                    // width: 800,
                    bottom: 0,
                    // left: 270,
                    right: 0,
                    // top: 0.01,
                    child: Opacity(
                      opacity: 0.12,
                      child: Image.asset(
                        "assets/texture.png",
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: GoogleFonts.inter(
                          color: greyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationDot,
                            color: secondaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "New york, USA",
                            style: GoogleFonts.inter(
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 102, 88, 254),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.solidBell,
                              color: whiteColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SearchScreen(
                                          searchQuery: value,
                                        ),
                                      ),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      color: primaryColor,
                                    ),
                                    hintText: "Search",
                                    hintStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: greyColor,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: const Icon(
                                FontAwesomeIcons.filter,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Suggested Jobs",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "See all",
                    style: GoogleFonts.inter(
                      fontSize: 19,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ReUsableMainCard(
              rondomApplicants: rondomApplicants,
              companyImage:
                  "https://www.vectorico.com/wp-content/uploads/2018/02/Behance-Logo-600x458.png",
              jobName: "UI Designer",
              companyName: "BrioSoft Solutions",
              companyLocation: "New York, USA",
              salary: 42,
            ),
          ],
        ),
      ),
    );
  }
}
