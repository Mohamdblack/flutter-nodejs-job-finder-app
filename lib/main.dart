import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/providers/job_provider.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/sign_in_screen.dart';
import 'package:shaqo_plus/services/auth_services.dart';
import 'package:shaqo_plus/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final onBoard = prefs.getBool("onBoard") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobProvider(),
        ),
      ],
      child: MyApp(
        isViewed: onBoard,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({required this.isViewed, Key? key}) : super(key: key);
  final bool isViewed;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getUserData() {
    AuthServices authServices = AuthServices();
    authServices.getUserData(context: context);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (widget.isViewed) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Error loading user data');
            } else {
              final userProvider = Provider.of<UserProvider>(context);
              if (userProvider.user.token.isNotEmpty) {
                return const BottomNav();
              } else {
                return const SignInScreen();
              }
            }
          } else {
            return const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
