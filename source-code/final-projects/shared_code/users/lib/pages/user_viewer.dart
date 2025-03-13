import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:users/models/user_model.dart';
import 'package:users/pages/user_list.dart';
import 'package:users/pages/user_list_detail_split_screen.dart';
import 'package:users/services/user_service.dart';

class UserViewer extends StatefulWidget {
  const UserViewer({
    super.key,
  });

  @override
  State<UserViewer> createState() => _UserViewerState();
}

class _UserViewerState extends State<UserViewer> {
  late ConnectionService connectionService;
  UserService userService = UserService();
  final ValueNotifier<User> _userDetailNotifier = ValueNotifier<User>(
    User.blankDefaultValues(),
  );

  @override
  void initState() {
    super.initState();
    connectionService = ConnectionService(
      clearDataList: userService.clearUserList,
      getDataList: userService.getUsersList,
    );
    _checkConnectivityRetrieveUser();
  }

  _checkConnectivityRetrieveUser() async {
    connectionService.isInternetConnectionAvailable();
    connectionService.watchConnectivity();
  }

  @override
  void dispose() {
    userService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<User>>(
          initialData: const [],
          stream: userService.userListStream,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<User>> snapshot,
          ) {
            if (snapshot.hasData == false) {
              return const Center(child: CircularProgressIndicator());
            }

            if (connectionService.isConnectionAvailable == false) {
              return const StatusMessage(
                message: 'Internet connection is not available',
                bannerMessage: 'none',
                bannerColor: Colors.yellow,
                textColor: Colors.black,
              );
            }

            List<User> userList = snapshot.requireData;

            return ResponsiveLayoutBuilder(
              mobile: UserList(
                isMobile: true,
                userList: userList,
                userDetailNotifier: _userDetailNotifier,
              ),
              webDesktopTablet: UserListDetailSplitScreen(
                userList: userList,
                userDetailNotifier: _userDetailNotifier,
              ),
            );
          },
        ),
      ),
    );
  }
}
