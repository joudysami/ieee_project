import 'package:flutter/material.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/feature/student/presentation/screens/assignments_screen.dart';

import '../admin/presentation/screens/home_screen.dart';
import '../admin/presentation/screens/manage_students_screen.dart';
import '../admin/presentation/screens/track_screen.dart';
import '../student/presentation/screens/home_screen.dart';
import '../student/presentation/screens/tracks_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late bool isAdmin = true;

  List<Widget>screensAdmin  = [
    HomeScreen(),
    TrackScreen(),
    ManageStudentsScreen(),
  ];
  List<Widget>screensStudent  = [
    HomeScreenStu(),
    TracksScreenStu(),
    AssignmentsScreenStu(),
  ];

int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.colors.white,
        selectedItemColor: context.colors.primary,
        unselectedItemColor: context.colors.blue.shade400,
        currentIndex: selectedIndex,
        onTap: _onBottomTapped,
        items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.school_outlined,
          ),
          label: "Tracks",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.assignment_outlined,
          ),
          label: isAdmin ? "Manage Students" : "Assignments",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
        ],
      ),

      body: isAdmin ? screensAdmin[selectedIndex] : screensStudent[selectedIndex],

    );
  }

  _onBottomTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
