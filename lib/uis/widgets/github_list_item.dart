import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../models/repository.dart';
import '../../utilities/url_launcher.dart';

class GitHubListItem extends StatelessWidget {
  final Repository repository;

  const GitHubListItem({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleImage(imageUrl: repository.owner.avatarUrl),
                  const SizedBox(width: 8),
                  // Don't remove this Expanded to wrap the author name
                  Expanded(
                    child: Text(
                      repository.owner.name,
                      style: kRepositoryHeaderFooterTextStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                repository.name,
                style: kRepositoryNameTextStyle,
              ),
              const SizedBox(height: 4),
              Text(
                repository.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: kRepositoryDescriptionTextStyle,
              ),
              const SizedBox(height: 16),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    (repository.stars / 1000).toStringAsFixed(1) + 'k',
                    style: kRepositoryHeaderFooterTextStyle,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.circle_rounded,
                    color: Colors.cyan,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repository.language,
                    style: kRepositoryHeaderFooterTextStyle,
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
        onTap: () =>
            UrlLauncher.launchInWebViewWithJavaScript(repository.htmlUrl),
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircleImage({
    Key? key,
    required this.imageUrl,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
