import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Student Screen!'),
      ),
    );
  }
}