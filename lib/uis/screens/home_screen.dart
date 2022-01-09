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
  var _isList = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Repositories>(context, listen: false).fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchableAppBar(),
      body: Consumer<Repositories>(
        builder: (context, repositoriesProvider, _) {
          switch (repositoriesProvider.status) {
            case Status.initial:
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.fail:
              return const Center(child: Text('An error has occurred'));
            case Status.success:
              return _isList
                  ? ListView.builder(
                      itemCount: repositoriesProvider.repositories.length,
                      itemBuilder: (context, index) {
                        final currentRepo =
                            repositoriesProvider.repositories[index];
                        return GitHubListItem(repository: currentRepo);
                      },
                    )
                  : GridView.builder(
                      itemCount: repositoriesProvider.repositories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final currentRepo =
                            repositoriesProvider.repositories[index];
                        return GitHubListItem(repository: currentRepo);
                      },
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
        _isList
            ? IconButton(
                icon: const Icon(Icons.grid_on_rounded),
                tooltip: 'Switch to Gird',
                onPressed: _switchView,
              )
            : IconButton(
                icon: const Icon(Icons.grid_off_rounded),
                tooltip: 'Switch to List',
                onPressed: _switchView,
              ),
      ],
    );
  }

  // Convert from List view to Grid view and vice versa
  void _switchView() => setState(() => _isList = !_isList);

  // Create a virtual screen with the upcoming new content from search
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

  // This method clear the search text field or pop if it is clear
  void _clearSearchOrPop() {
    _searchController.text.isNotEmpty
        ? setState(() => _searchController.clear())
        : Navigator.pop(context);
  }
}
