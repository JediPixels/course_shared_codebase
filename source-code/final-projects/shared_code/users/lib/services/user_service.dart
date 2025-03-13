import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:users/helpers/api_url.dart';
import 'package:users/models/user_model.dart';

class UserService {
  UserService() {
    clearUserList();
  }

  final StreamController<List<User>> _userListController =
      StreamController<List<User>>();
  Sink<List<User>> get _addUserList => _userListController.sink;
  Stream<List<User>> get userListStream => _userListController.stream;
  final List<User> _userList = <User>[];

  void dispose() {
    _userListController.close();
  }

  void _addUser(List<User> addToUserList) {
    // Add Users to the existing User List
    _userList.addAll(addToUserList);
    _addUserList.add(addToUserList);
  }

  void refreshCurrentListTopics() {
    _addUserList.add(_userList);
  }

  void clearUserList() {
    List<User> emptyList = <User>[];
    _addUser(emptyList);
  }

  Future<List<User>> getUsersList() async {
    final String resultsBody =
        await APIService.getSearch(ApiUrl.apiBaseAndQueryUrl);
    final List<User> results = UserModel.fromRawJson(resultsBody).users;

    if (results.isEmpty) {
      debugPrint('Error Code: $results}');
    }

    _addUser(results);
    return results;
  }
}
