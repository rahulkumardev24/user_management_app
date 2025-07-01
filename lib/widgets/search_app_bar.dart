import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final Function(String) onSearchChanged;
  final VoidCallback onToggleSearch;
  final Future<void> Function() onRefresh;

  const SearchAppBar({
    super.key,
    required this.isSearching,
    required this.onSearchChanged,
    required this.onToggleSearch,
    required this.onRefresh,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      title: isSearching
          ? TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search users...',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              HapticFeedback.lightImpact();
              onToggleSearch();
            },
          ),
        ),
        onChanged: onSearchChanged,
      )
          : const Text('User Management'),
      centerTitle: true,
      actions: [
        if (!isSearching)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              HapticFeedback.lightImpact();
              onToggleSearch();
            },
          ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            HapticFeedback.lightImpact();
            await onRefresh();
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}