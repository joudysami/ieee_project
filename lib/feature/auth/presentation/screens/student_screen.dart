import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/helpers/cache_help.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Screen'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              await CacheHelp.clearSession();
              if (context.mounted) {
                context.go('/loginScreen');
              }
            },
            child: Text(AppString.signOut),
          ),
          const Center(child: Text('Welcome to the Student Screen!')),
        ],
      ),
    );
  }
}