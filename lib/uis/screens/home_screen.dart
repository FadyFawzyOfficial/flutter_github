import 'package:flutter/material.dart';
import 'package:github/models/repository.dart';
import 'package:github/uis/widgets/github_list_item.dart';
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
      body: FutureBuilder(
        future: Provider.of<Repositories>(context, listen: false)
            .fetchRepositories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.error != null) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Consumer<Repositories>(
              builder: (context, repositoriesProvider, _) => ListView.builder(
                itemCount: repositoriesProvider.repositories.length,
                itemBuilder: (context, index) {
                  final currentRepo = repositoriesProvider.repositories[index];
                  return GitHubListItem(repository: currentRepo);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
