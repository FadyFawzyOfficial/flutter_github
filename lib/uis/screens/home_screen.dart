import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/repositories.dart';
import '../widgets/github_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchableAppBar(),
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

  AppBar _buildSearchableAppBar() {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Find a Repository ...',
              ),
              onSubmitted: (value) =>
                  Provider.of<Repositories>(context, listen: false)
                      .fetchRepositories(searchKeyWord: value),
            )
          : const Text('GitHub'),
      actions: [
        _isSearching
            ? IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: () => _clearSearchOrPop(),
              )
            : IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: _startSearch,
              ),
      ],
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() => _isSearching = true);
  }

  void _stopSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
    });
  }

  void _clearSearchOrPop() {
    _searchController.text.isNotEmpty
        ? setState(() => _searchController.clear())
        : Navigator.pop(context);
  }
}
