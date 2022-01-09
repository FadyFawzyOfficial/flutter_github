import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';
import '../models/repository.dart';

// Enums to define the state of the Repositories Provider (Loading, Success Loaded, ...)
enum Status {
  initial,
  loading,
  success,
  fail,
}

class Repositories extends ChangeNotifier {
  Status _status = Status.initial;
  List<Repository> _repositories = [];

  Status get status => _status;

  List<Repository> get repositories => _repositories;

  Future<void> fetchRepositories({String? searchKeyWord}) async {
    final queryParameters = {'q': searchKeyWord ?? 'flutter'};
    final uri = Uri.https(baseUrl, searchRepositoriesUrlPath, queryParameters);

    // Set the status of the provider to loading status before searching process.
    if (searchKeyWord != null) emitLoadingState();

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        _repositories = List<Repository>.from(
            responseBody['items'].map((x) => Repository.fromMap(x)));

        emitSuccessState();
      }
    } catch (e) {
      emitFailState();
      rethrow;
    }
  }

  void emitLoadingState() {
    _status = Status.loading;
    notifyListeners();
  }

  void emitSuccessState() {
    _status = Status.success;
    notifyListeners();
  }

  void emitFailState() {
    _status = Status.fail;
    notifyListeners();
  }
}
