import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/job.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/utilis/error_handler.dart';

class SearchServices {
  Future<List<Jobs>> searchJobs({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Jobs> jobsList = [];

    try {
      final response = await http.get(
        Uri.parse("$JObURI/job/search/$searchQuery"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.user.token,
        },
      );

      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            jobsList.add(
              Jobs.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
    return jobsList;
  }
}
