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
import 'package:shaqo_plus/utilis/error_handler.dart';
import 'package:shaqo_plus/widgets/reusable_job_type.dart';
import 'package:shaqo_plus/widgets/reusbale_button.dart';
import 'package:http/http.dart' as http;

class MyJobs extends StatefulWidget {
  const MyJobs({
    super.key,
  });

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  List<Jobs>? myJobs;
  final JobServices jobServices = JobServices();

  getMyOwnJobs() async {
    myJobs = await jobServices.getMyOwnJobs(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyOwnJobs();
  }

  Future<void> updatteJob(String jobId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    Jobs jobs = Jobs(
      id: "",
      companyName: userProvider.companyName,
      jobName: _jobNameController.text,
      jobSalary: int.parse(_jobSalaryController.text),
      jobType: _jobTypeController.text,
      workingModel: _workingModelController.text,
      jobLevel: _jobLevelController.text,
      jobLocation: _jobLocationController.text,
      createdBy: userProvider.id,
      companyProfile: userProvider.profile,
    );

    try {
      final response = await http.patch(
        Uri.parse("$JObURI/job/$jobId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token
        },
        body: jobs.toJson(),
      );
      // ignore: use_build_context_synchronously
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          log("Job Updated successfully...");
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  TextEditingController _jobNameController = TextEditingController();
  TextEditingController _jobSalaryController = TextEditingController();
  TextEditingController _jobTypeController = TextEditingController();
  TextEditingController _workingModelController = TextEditingController();
  TextEditingController _jobLevelController = TextEditingController();
  TextEditingController _jobLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return myJobs == null
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              centerTitle: true,
              title: const Text("My Jobs List"),
            ),
            backgroundColor: const Color.fromARGB(255, 240, 242, 250),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                  itemCount: myJobs!.length,
                  itemBuilder: (context, index) {
                    final jobData = myJobs![index];
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
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: const Color.fromARGB(
                                                255, 240, 242, 250),
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                TextField(
                                                  controller:
                                                      _jobNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Job Name',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  controller:
                                                      _jobSalaryController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Job Salary',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  controller:
                                                      _jobTypeController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Job Type',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  controller:
                                                      _workingModelController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Working Model',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  controller:
                                                      _jobLevelController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Job Level',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  controller:
                                                      _jobLocationController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Job Location',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const SizedBox(height: 16.0),
                                                ReUsableBtn(
                                                  ontap: () {
                                                    updatteJob(jobData.id);
                                                    Navigator.pop(context);
                                                  },
                                                  btnText: "Update job",
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      _jobNameController =
                                          TextEditingController(
                                        text: jobData.jobName,
                                      );
                                      _jobSalaryController =
                                          TextEditingController(
                                        text: jobData.jobSalary.toString(),
                                      );
                                      _jobTypeController =
                                          TextEditingController(
                                        text: jobData.jobType,
                                      );
                                      _workingModelController =
                                          TextEditingController(
                                        text: jobData.workingModel,
                                      );
                                      _jobLevelController =
                                          TextEditingController(
                                        text: jobData.jobLevel,
                                      );
                                      _jobLocationController =
                                          TextEditingController(
                                        text: jobData.jobLocation,
                                      );

                                      log(jobData.jobName);
                                    },
                                    child: const Icon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 30,
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
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  "Delete",
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Are you sure you want to delete?',
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.0,
                                                    color: greyColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 16.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                189, 189, 189),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Cancel",
                                                            style: GoogleFonts
                                                                .inter(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          jobServices.deleteJob(
                                                            context: context,
                                                            jobId: jobData.id,
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Yes, Delete",
                                                            style: GoogleFonts
                                                                .inter(
                                                              color: whiteColor,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      FontAwesomeIcons.trash,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
  }
}
