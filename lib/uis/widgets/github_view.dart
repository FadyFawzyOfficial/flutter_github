import 'package:flutter/material.dart';

import '../../models/repository.dart';
import 'github_item.dart';

class GitHubView extends StatelessWidget {
  final List<Repository> repositories;
  final bool isList;

  const GitHubView({
    Key? key,
    required this.isList,
    required this.repositories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => isList
      ? ListView.builder(
          itemCount: repositories.length,
          itemBuilder: (context, index) =>
              GitHubItem(repository: repositories[index]),
        )
      : GridView.builder(
          itemCount: repositories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 250,
          ),
          itemBuilder: (context, index) => GitHubItem(
            repository: repositories[index],
            isList: false,
          ),
        );
}
