import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/repositories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Trigger'),
          onPressed: Provider.of<Repositories>(context, listen: false)
              .fetchRepositories,
        ),
      ),
    );
  }
}
