import 'package:flutter/material.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/feature/admin/presentation/screens/home_screen.dart';
import 'package:ieee/feature/student/presentation/screens/assignments_screen.dart';
import 'package:ieee/feature/student/presentation/screens/home_screen_stu.dart';
import 'package:ieee/feature/student/presentation/screens/tracks_screen.dart';

import '../../core/helpers/cache_help.dart';
import '../admin/presentation/screens/manage_students_screen.dart';
import '../admin/presentation/screens/profile_screen.dart';
import '../admin/presentation/screens/track_screen.dart';
import '../student/presentation/screens/profile_screen_stu.dart';

class LayoutScreen extends StatefulWidget {
  final String? role;
  const LayoutScreen({super.key, this.role});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  String? _role;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _resolveRole();
  }

  Future<void> _resolveRole() async {
    _role = widget.role ?? CacheHelp.getUser()?.role ?? 'Student';
    setState(() => _loading = false);
  }

  bool get isAdmin => _role == 'Admin';

  List<Widget> get _screens => isAdmin
      ? const [
          HomeScreen(),
          ManageStudentsScreen(),
          TrackScreen(),
          ProfileScreen(),
        ]
      : const [
          HomeScreenStu(),
          TracksScreenStu(),
          AssignmentsScreenStu(),
          ProfileScreenStu(),
        ];

  List<BottomNavigationBarItem> get _navItems => isAdmin
      ? const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Manage Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ]
      : const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Tracks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: context.colors.primary,
        unselectedItemColor: context.colors.sky.shade400,
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: _navItems,
      ),
    );
  }
}
