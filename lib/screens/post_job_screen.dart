import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/services/job_services.dart';
import 'package:shaqo_plus/widgets/reusbale_button.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  _PostJobScreenState createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final JobServices jobServices = JobServices();

  void createJob() {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    jobServices.createJob(
      context: context,
      companyName: userProvider.companyName,
      jobName: _jobNameController.text,
      jobSalary: int.parse(_jobSalaryController.text),
      jobLocation: _jobLocationController.text,
      createdBy: userProvider.id,
      companyProfile: userProvider.profile,
    );

    _jobNameController.clear();
    _jobSalaryController.clear();
    _jobLocationController.clear();
  }

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _jobSalaryController = TextEditingController();
  final TextEditingController _jobLocationController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _jobNameController.dispose();
    _jobSalaryController.dispose();
    _jobLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      appBar: AppBar(
        title: const Text('Post a Job'),
        backgroundColor: const Color.fromARGB(255, 240, 242, 250),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _jobNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Job Name',
                hintText: 'Enter job name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _jobSalaryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Job Salary',
                hintText: 'Enter job salary',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _jobLocationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Job Location',
                hintText: 'Enter job location',
              ),
            ),
            const SizedBox(height: 16.0),
            ReUsableBtn(
                ontap: () {
                  createJob();
                },
                btnText: "Post Job")
          ],
        ),
      ),
    );
  }
}
