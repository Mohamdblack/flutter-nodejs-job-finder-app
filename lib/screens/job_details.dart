import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/job.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/job_details_about.dart';
import 'package:shaqo_plus/screens/job_details_company.dart';
import 'package:shaqo_plus/screens/job_details_review.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/widgets/job_detail_card.dart';
import 'package:shaqo_plus/widgets/reusbale_button.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, required this.jobData});

  final Jobs jobData;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        FontAwesomeIcons.arrowLeftLong,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.bookmark,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.shareNodes,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    widget.jobData.companyProfile,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.jobData.jobName,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.jobData.companyName,
                  style: GoogleFonts.inter(
                    color: greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.jobData.jobLocation,
                      style: GoogleFonts.inter(
                        color: greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          JobDetailCard(
                            iconName: FontAwesomeIcons.sackDollar,
                            titleName: "Salary(Monthly)",
                            descName: "\$${widget.jobData.jobSalary}K",
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          JobDetailCard(
                            iconName: FontAwesomeIcons.bagShopping,
                            titleName: "Job Type",
                            descName: widget.jobData.jobType,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          JobDetailCard(
                            iconName: FontAwesomeIcons.stackExchange,
                            titleName: "Working Model",
                            descName: widget.jobData.workingModel,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          JobDetailCard(
                            iconName: FontAwesomeIcons.chartBar,
                            titleName: "Level",
                            descName: widget.jobData.jobLevel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TabBar(
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              labelStyle: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              controller: _tabController,
              tabs: const [
                Tab(text: 'About '),
                Tab(text: ' Company'),
                Tab(text: 'Review'),
                // Add more tabs if needed
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  // Contents for 'About Company' tab
                  About(),
                  Company(),
                  // Contents for 'Review' tab
                  Review(),
                  // Add more TabBarView children if needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: userProvider.id == widget.jobData.createdBy
                  ? Container()
                  : ReUsableBtn(ontap: () {}, btnText: "Apply for job"),
            ),
          ],
        ),
      ),
    );
  }
}
