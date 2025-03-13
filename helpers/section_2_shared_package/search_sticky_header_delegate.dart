import 'package:flutter/material.dart';
import 'package:shared/helpers/themes.dart';

/// SearchStickyHeaderDelegate
class SearchStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// Used by Search to keep Search TextField sticky to the top of the list
  /// Pass the [TextEditingController] [searchEditingController]
  SearchStickyHeaderDelegate({
    required this.searchEditingController,
    required this.searchOnChangedCallback,
  });

  final TextEditingController searchEditingController;
  final Function(String searchValue)? searchOnChangedCallback;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 56.0,
          child: TextField(
            autofocus: true,
            controller: searchEditingController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(8.0),
              suffixIcon: const Icon(Icons.search),
              fillColor: ThemeColors.lightBlue.withOpacity(0.3),
              filled: true,
              hintText: 'Search...',
            ),
            onChanged: (String searchValue) {
              searchOnChangedCallback!(searchValue);
            },
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
