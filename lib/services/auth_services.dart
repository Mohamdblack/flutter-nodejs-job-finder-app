import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/user.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/sign_in_screen.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/utilis/error_handler.dart';
import 'package:shaqo_plus/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AuthServices {
  // ? Sign Up || Register
  void signUpUser({
    required BuildContext context,
    required String companyName,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: "id",
        companyName: companyName,
        email: email,
        location: "Mogadishu, Somalia",
        password: password,
        role: "seeker",
        profile:
            "https://www.vectorico.com/wp-content/uploads/2018/02/Behance-Logo-600x458.png",
        token: "",
      );
      final response = await http.post(Uri.parse("$AuthURI/register"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      // ignore: use_build_context_synchronously
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          Toast.show("Account Created successfully...");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SignInScreen(),
            ),
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      Toast.show(e.toString());
    }
  }

  // ? Sign In || Login

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      ToastContext toastContext = ToastContext();
      toastContext.init(context);
      final response = await http.post(Uri.parse("$AuthURI/login"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      // ignore: use_build_context_synchronously
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          Toast.show("Login Successfull..");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          await prefs.setString("token", jsonDecode(response.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNav(),
            ),
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      Toast.show(
        e.toString(),
      );
    }
  }

  //  & Get User Data
  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      //  * hadii uu token null noqdo waxa ku shubena empty string (for the purpose of first time user)
      if (token == null) {
        prefs.setString("token", "");
      }

      var tokenResponse = await http.post(Uri.parse("$AuthURI/tokenIsValid"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token!
          });

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        // * Get the user data if response is true

        final userResponse = await http.get(Uri.parse("$AuthURI/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Toast.show(
        e.toString(),
      );
    }
  }

  // * Update User info
  Future<void> updateJob({
    required BuildContext context,
    required String userId,
    required String companyName,
    required String email,
    required String location,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    User user = User(
        id: "id",
        companyName: companyName,
        email: email,
        location: location,
        password: userProvider.password,
        role: userProvider.role,
        profile: userProvider.profile,
        token: userProvider.token);

    try {
      final response = await http.patch(
        Uri.parse("$AuthURI/$userId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token
        },
        body: user.toJson(),
      );
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          Toast.show("User Updated successfully...");
        },
      );
    } catch (e) {
      Toast.show(e.toString());
    }
  }
}
