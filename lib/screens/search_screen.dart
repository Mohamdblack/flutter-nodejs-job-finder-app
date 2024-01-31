import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/job.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/job_details.dart';
import 'package:shaqo_plus/services/search_services.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/widgets/reusable_job_type.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Jobs>? jobs;

  @override
  void initState() {
    super.initState();
    searchJobs();
  }

  searchJobs() async {
    jobs = await searchServices.searchJobs(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;

    return jobs == null
        ? const Center(
            child: CircularProgressIndicator(color: primaryColor),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 240, 242, 250),
            appBar: AppBar(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView.builder(
                itemCount: jobs!.length,
                itemBuilder: (context, index) {
                  final jobData = jobs![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailsScreen(jobData: jobData),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        index.compareTo(0) == 1
                            ? const Text("")
                            : Text(
                                "${jobs!.length.toString()} Results Found",
                                style: GoogleFonts.inter(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: greyColor,
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         for (int i = 0;
                                  //             i < widget.rondomApplicants.length;
                                  //             i++)
                                  //           Align(
                                  //             widthFactor: 0.5,
                                  //             child: CircleAvatar(
                                  //               radius: 19,
                                  //               backgroundColor: Colors.blue,
                                  //               child: CircleAvatar(
                                  //                 radius: 17,
                                  //                 backgroundImage: NetworkImage(
                                  //                   widget.rondomApplicants[i],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(
                                  //       height: 6,
                                  //     ),
                                  //     Text(
                                  //       "322 Applicants",
                                  //       style: GoogleFonts.inter(
                                  //         color: greyColor,
                                  //         fontWeight: FontWeight.w500,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
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
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
