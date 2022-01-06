import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub'),
      ),
      body: const Center(
        child: Text(
          'Created & Developed by\n Eng. Fady Fawzy',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
