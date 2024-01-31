import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/job.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/job_details.dart';
import 'package:shaqo_plus/services/job_services.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/widgets/reusable_job_type.dart';

class ReUsableMainCard extends StatefulWidget {
  const ReUsableMainCard({
    super.key,
    required this.rondomApplicants,
    required this.companyImage,
    required this.jobName,
    required this.companyName,
    required this.companyLocation,
    required this.salary,
  });

  final List rondomApplicants;
  final String companyImage;
  final String jobName;
  final String companyName;
  final String companyLocation;
  final int salary;

  @override
  State<ReUsableMainCard> createState() => _ReUsableMainCardState();
}

class _ReUsableMainCardState extends State<ReUsableMainCard> {
  List<Jobs>? jobs;
  final JobServices jobServices = JobServices();
  @override
  void initState() {
    super.initState();
    getAllJobs();
  }

  getAllJobs() async {
    jobs = await jobServices.getAllJobs(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return Expanded(
      child: jobs == null
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : ListView.builder(
              itemCount: jobs!.length,
              itemBuilder: (context, index) {
                final jobData = jobs![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailsScreen(
                            jobData: jobData,
                          ),
                        ),
                      );
                      log((jobData.companyName).toString());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  jobData.companyProfile,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobData.jobName,
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    jobData.companyName,
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              userProvider.id == jobData.createdBy
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        log("Bookmark");
                                      },
                                      child: const Icon(
                                        FontAwesomeIcons.bookmark,
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.locationDot,
                                size: 25,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                jobData.jobLocation,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: greyColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReUsableJobType(
                                jobType: jobData.jobType,
                              ),
                              ReUsableJobType(
                                jobType: jobData.workingModel,
                              ),
                              ReUsableJobType(
                                jobType: jobData.jobLevel,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      for (int i = 0;
                                          i < widget.rondomApplicants.length;
                                          i++)
                                        Align(
                                          widthFactor: 0.5,
                                          child: CircleAvatar(
                                            radius: 19,
                                            backgroundColor: Colors.blue,
                                            child: CircleAvatar(
                                              radius: 17,
                                              backgroundImage: NetworkImage(
                                                widget.rondomApplicants[i],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "322 Applicants",
                                    style: GoogleFonts.inter(
                                      color: greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "\$${jobData.jobSalary}k",
                                      style: GoogleFonts.inter(
                                        color: primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '/month',
                                      style: GoogleFonts.inter(
                                        color: greyColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
