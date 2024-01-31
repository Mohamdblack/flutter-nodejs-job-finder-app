import 'package:flutter/material.dart';
import 'package:shaqo_plus/models/job.dart';

class JobProvider extends ChangeNotifier {
  Jobs _jobs = Jobs(
    id: "",
    companyName: "",
    jobName: "",
    jobSalary: 0,
    jobType: "",
    workingModel: "",
    jobLevel: "",
    jobLocation: "",
    companyProfile: "",
    createdBy: "",
  );

  Jobs get jobs => _jobs;

  void setJobs(String jobs) {
    _jobs = Jobs.fromJson(jobs);
    notifyListeners();
  }
}
