import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void customErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Toast.show(jsonDecode(response.body)['msg']);
      break;
    case 500:
      Toast.show(jsonDecode(response.body)['error']);
      break;
    default:
      log(
        response.body,
      );
  }
}
