import 'dart:async';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService;

  UserProvider(this._userService) {
    fetchUsers();
  }

  List<User> _users = [];
  List<User> _localUsers = [];
  bool _isLoading = false;
  String? _error;

  List<User> get users => [..._users, ..._localUsers];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final users = await _userService.fetchUsers().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
            'The connection has timed out. Please check your internet connection.',
          );
        },
      );
      _users = users;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  addUser(User user) {
    _localUsers.add(user);
    notifyListeners();
  }

  List<User> searchUsers(String query) {
    if (query.isEmpty) return users;
    return users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
