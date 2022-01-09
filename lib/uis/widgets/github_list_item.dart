import 'package:flutter/material.dart';

import '../../models/repository.dart';
import '../../utilities/url_launcher.dart';

class GitHubListItem extends StatelessWidget {
  const GitHubListItem({
    Key? key,
    required this.repository,
  }) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(repository.owner.avatarUrl),
        title: Text(repository.name),
        subtitle: Text(repository.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            Text('${repository.stars}'),
          ],
        ),
        onTap: () =>
            UrlLauncher.launchInWebViewWithJavaScript(repository.htmlUrl),
      ),
    );
  }
}
