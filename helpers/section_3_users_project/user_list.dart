import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:users/models/user_model.dart';
import 'package:users/pages/user_detail.dart';

class UserList extends StatefulWidget {
  const UserList({
    super.key,
    required this.isMobile,
    required this.userList,
    required this.userDetailNotifier,
  });

  final bool isMobile;
  final List<User> userList;
  final ValueNotifier<User> userDetailNotifier;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => UserListCustomScrollView(
                  isMobile: widget.isMobile,
                  userList: widget.userList,
                  userDetailNotifier: widget.userDetailNotifier,
                ),
              );
            },
          )
        : UserListCustomScrollView(
            isMobile: widget.isMobile,
            userList: widget.userList,
            userDetailNotifier: widget.userDetailNotifier,
          );
  }
}

class UserListCustomScrollView extends StatefulWidget {
  const UserListCustomScrollView({
    super.key,
    required this.isMobile,
    required this.userList,
    required this.userDetailNotifier,
  });

  final bool isMobile;
  final List<User> userList;
  final ValueNotifier<User> userDetailNotifier;

  @override
  State<UserListCustomScrollView> createState() =>
      _UserListCustomScrollViewState();
}

class _UserListCustomScrollViewState extends State<UserListCustomScrollView> {
  List<User> _searchUserList = [];
  bool _isSearchVisible = false;
  final TextEditingController _searchEditingController =
      TextEditingController();

  void _searchChangedCallback(String filter) {
    setState(() {
      _searchUserList = widget.userList
          .where((user) =>
              user.firstName.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.50),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: ThemeColors.black,
                ),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'User Viewer',
                    applicationVersion: 'v1.0',
                    applicationIcon: const Icon(Icons.self_improvement_rounded),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.50),
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: ThemeColors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearchVisible = !_isSearchVisible;
                      if (_isSearchVisible == false) {
                        _searchEditingController.text = '';
                      } else {
                        _searchUserList = widget.userList;
                      }
                    });
                  },
                ),
              ),
            )
          ],
          stretch: true,
          pinned: true,
          forceElevated: true,
          expandedHeight: MediaQuery.sizeOf(context).height / 4,
          collapsedHeight: 60.0,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            title: Text(
              'Users Viewer',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).indicatorColor,
                decorationThickness: 0.0,
                shadows: <Shadow>[
                  const Shadow(
                    color: ThemeColors.black,
                    offset: Offset(1, 1),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            centerTitle: true,
            // background: const Icon(
            //   Icons.people,
            //   size: 128.0,
            // ),
            background: Image.asset(
              'assets/images/users.png',
              fit: BoxFit.none,
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.all(4.0)),

        // Search
        SliverAnimatedOpacity(
          opacity: _isSearchVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          sliver: _isSearchVisible
              ? SliverPersistentHeader(
                  delegate: SearchStickyHeaderDelegate(
                    searchEditingController: _searchEditingController,
                    searchOnChangedCallback: _searchChangedCallback,
                  ),
                  pinned: true,
                )
              : const SliverToBoxAdapter(child: SizedBox()),
        ),

        SliverList.separated(
          itemCount: _isSearchVisible
              ? _searchUserList.length
              : widget.userList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                _isSearchVisible
                    ? _searchUserList[index].firstName
                    : widget.userList[index].firstName,
              ),
              onTap: () {
                widget.userDetailNotifier.value = _isSearchVisible
                    ? _searchUserList[index]
                    : widget.userList[index];
                if (widget.isMobile) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserDetail(
                        user: _isSearchVisible
                            ? _searchUserList[index]
                            : widget.userList[index],
                      ),
                    ),
                  );
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ],
    );
  }
}
