import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/job.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/utilis/error_handler.dart';
import 'package:toast/toast.dart';

class JobServices {
  // * Create jobs

  void createJob({
    required BuildContext context,
    required String companyName,
    required String jobName,
    required int jobSalary,
    required String jobLocation,
    required String companyProfile,
    required String createdBy,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    try {
      Jobs jobs = Jobs(
        id: "",
        companyName: userProvider.companyName,
        jobName: jobName,
        jobSalary: jobSalary,
        jobType: "Full-Time",
        workingModel: "Remote",
        jobLevel: "Internship",
        jobLocation: jobLocation,
        createdBy: userProvider.id,
        companyProfile: userProvider.profile,
      );

      final response = await http.post(
        Uri.parse("$JObURI/job/create-job"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token
        },
        body: jobs.toJson(),
      );
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          Toast.show("Job added successfully...");
        },
      );
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  // ? Get All Jobs
  Future<List<Jobs>> getAllJobs({
    required BuildContext context,
  }) async {
    List<Jobs> jobsList = [];
    try {
      final response = await http.get(
        Uri.parse("$JObURI/job"),
      );

      // ignore: use_build_context_synchronously
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            jobsList.add(
              Jobs.fromJson(
                jsonEncode(jsonDecode(response.body)[i]),
              ),
            );
          }
          // Provider.of<JobProvider>(context, listen: false)
          //     .setJobs(jobsList.toString());
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      Toast.show(e.toString());
    }
    return jobsList;
  }

  // * Get My Own Jobs
  Future<List<Jobs>> getMyOwnJobs({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    List<Jobs> jobsList = [];
    try {
      final response = await http.get(
        Uri.parse("$JObURI/job/own-jobs"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token
        },
      );

      // ignore: use_build_context_synchronously
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            jobsList.add(
              Jobs.fromJson(
                jsonEncode(jsonDecode(response.body)[i]),
              ),
            );
          }
          // Provider.of<JobProvider>(context, listen: false)
          //     .setJobs(jobsList.toString());
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      Toast.show(e.toString());
    }
    return jobsList;
  }

  // * Update jobs

  Future<void> updateJob({
    required BuildContext context,
    required String jobId,
    required String jobName,
    required int jobSalary,
    required String jobLocation,
    required String jobType,
    required String workingModel,
    required String jobLevel,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    Jobs jobs = Jobs(
      id: "",
      companyName: userProvider.companyName,
      jobName: jobName,
      jobSalary: jobSalary,
      jobType: jobType,
      workingModel: workingModel,
      jobLevel: jobLevel,
      jobLocation: jobLocation,
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
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          Toast.show("Job Updated successfully...");
        },
      );
    } catch (e) {
      Toast.show(e.toString());
    }
  }
  // * Delete jobs

  Future<void> deleteJob({
    required BuildContext context,
    required String jobId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final response = await http.delete(
        Uri.parse("$JObURI/job/$jobId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token
        },
      );
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          Toast.show("Job deleted successfully...");
        },
      );
    } catch (e) {
      Toast.show(e.toString());
    }
  }
}
