import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/models/user.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/sign_in_screen.dart';
import 'package:shaqo_plus/themes/colors.dart';
import 'package:shaqo_plus/utilis/error_handler.dart';
import 'package:shaqo_plus/utilis/utilis.dart';
import 'package:shaqo_plus/widgets/reusbale_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  Future<void> updatteUser(String userId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    User user = User(
      id: "",
      companyName: _companyNameController.text,
      email: _emailController.text,
      location: _locationController.text,
      password: userProvider.password,
      role: userProvider.role,
      profile: userProvider.profile,
      token: userProvider.token,
    );

    try {
      ToastContext toastContext = ToastContext();
      toastContext.init(context);
      final response = await http.patch(
        Uri.parse("$AuthURI/$userId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token
        },
        body: user.toJson(),
      );
      // ignore: use_build_context_synchronously
      customErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          Toast.show("User Updated successfully...");
          _companyNameController.clear();
          _emailController.clear();
          _locationController.clear();
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 242, 250),
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("token", '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInScreen(),
                  ),
                );
              },
              child: const Icon(
                FontAwesomeIcons.arrowRightFromBracket,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(userProvider.profile),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _companyNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: userProvider.companyName,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: userProvider.email,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: userProvider.location,
                  ),
                ),
                const SizedBox(height: 16.0),
                ReUsableBtn(
                  ontap: () {
                    updatteUser(userProvider.id);
                  },
                  btnText: "Update Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
