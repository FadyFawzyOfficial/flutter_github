import 'dart:convert';

class Owner {
  String name;
  String avatarUrl;
  String htmlUrl;

  Owner({
    required this.name,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      name: map['login'],
      avatarUrl: map['avatar_url'],
      htmlUrl: map['html_url'],
    );
  }

  factory Owner.fromJson(String source) => Owner.fromMap(json.decode(source));
}
