import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';
import '../models/repository.dart';

class Repositories extends ChangeNotifier {
  List<Repository> _repositories = [];

  List<Repository> get repositories => _repositories;

  Future<void> fetchRepositories({String? searchKeyWord}) async {
    final queryParameters = {'q': searchKeyWord ?? 'flutter'};
    final uri = Uri.https(baseUrl, searchRepositoriesUrlPath, queryParameters);
    debugPrint(uri.toString());

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
        final Map<String, dynamic> responseBody = json.decode(response.body);
        _repositories = List<Repository>.from(
            responseBody['items'].map((x) => Repository.fromMap(x)));
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
