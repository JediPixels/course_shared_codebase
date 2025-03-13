import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:users/models/user_model.dart';
import 'package:users/pages/user_detail.dart';
import 'package:users/pages/user_list.dart';

class UserListDetailSplitScreen extends StatelessWidget {
  const UserListDetailSplitScreen({
    super.key,
    required this.userList,
    required ValueNotifier<User> userDetailNotifier,
  }) : _userDetailNotifier = userDetailNotifier;

  final List<User> userList;
  final ValueNotifier<User> _userDetailNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // List
        SizedBox(
          width: ResponsiveSizes.sidebarWidth.value,
          child: UserList(
            isMobile: false,
            userList: userList,
            userDetailNotifier: _userDetailNotifier,
          ),
        ),

        const VerticalDivider(width: 1.0),

        // Details
        Expanded(
          child: ValueListenableBuilder<User>(
            valueListenable: _userDetailNotifier,
            builder: (
              BuildContext context,
              User user,
              Widget? child,
            ) {
              return UserDetail(
                user: user,
              );
            },
          ),
        ),
      ],
    );
  }
}
