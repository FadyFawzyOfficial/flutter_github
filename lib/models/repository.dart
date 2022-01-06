import 'dart:convert';

import 'owner.dart';

class Repository {
  String name;
  String description;
  String htmlUrl;
  String language;
  int stars;
  int watchers;
  int forks;
  Owner owner;

  Repository({
    required this.name,
    required this.description,
    required this.htmlUrl,
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.owner,
  });

  factory Repository.fromMap(Map<String, dynamic> map) {
    return Repository(
      name: map['name'],
      description: map['description'],
      htmlUrl: map['html_url'],
      language: map['language'],
      stars: map['stargazers_count'],
      watchers: map['watchers'],
      forks: map['forks'],
      owner: Owner.fromMap(map['owner']),
    );
  }

  factory Repository.fromJson(String source) =>
      Repository.fromMap(json.decode(source));
}
