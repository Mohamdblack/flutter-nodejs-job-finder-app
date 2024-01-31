import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shaqo_plus/providers/user_provider.dart';
import 'package:shaqo_plus/screens/home_screen.dart';
import 'package:shaqo_plus/screens/my_jobs.dart';
import 'package:shaqo_plus/screens/post_job_screen.dart';
import 'package:shaqo_plus/screens/profile_screen.dart';
import 'package:shaqo_plus/themes/colors.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List _pages = [
    HomeScreen(),
    MyJobs(),
    PostJobScreen(),
    Center(child: Text("Bookmark")),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 16,
        ),
        selectedItemColor: primaryColor,
        elevation: 0,
        showUnselectedLabels: true,
        unselectedItemColor: greyColor,
        backgroundColor: const Color.fromARGB(255, 240, 242, 250),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bagShopping),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: userProvider.role == 'seeker'
                ? Container()
                : const FaIcon(FontAwesomeIcons.circlePlus),
            label: userProvider.role == 'seeker' ? "" : 'Add',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidBookmark),
            label: 'Bookmark',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
