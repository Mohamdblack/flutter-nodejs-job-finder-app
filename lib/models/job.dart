import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Jobs {
  final String id;
  final String companyName;
  final String jobName;
  final int jobSalary;
  final String jobType;
  final String workingModel;
  final String jobLevel;
  final String jobLocation;
  final String companyProfile;
  final String createdBy;
  Jobs({
    required this.id,
    required this.companyName,
    required this.jobName,
    required this.jobSalary,
    required this.jobType,
    required this.workingModel,
    required this.jobLevel,
    required this.jobLocation,
    required this.companyProfile,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'jobName': jobName,
      'jobSalary': jobSalary,
      'jobType': jobType,
      'workingModel': workingModel,
      'jobLevel': jobLevel,
      'jobLocation': jobLocation,
      'companyProfile': companyProfile,
      'createdBy': createdBy,
    };
  }

  factory Jobs.fromMap(Map<String, dynamic> map) {
    return Jobs(
      id: map['_id'] ?? "",
      companyName: map['companyName'] ?? "",
      jobName: map['jobName'] ?? "",
      jobSalary: map['jobSalary'] ?? 0,
      jobType: map['jobType'] ?? "",
      workingModel: map['workingModel'] ?? "",
      jobLevel: map['jobLevel'] ?? "",
      jobLocation: map['jobLocation'] ?? "",
      companyProfile: map['companyProfile'] ?? "",
      createdBy: map['createdBy'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Jobs.fromJson(String source) =>
      Jobs.fromMap(json.decode(source) as Map<String, dynamic>);
}
