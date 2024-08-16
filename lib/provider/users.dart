import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learningapp/data/dummy_users.dart';
import 'package:learningapp/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = Map<String, User>.from(DUMMY_USERS);

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (_) => User(
            id: user.id,
            name: user.name,
            email: user.email,
            avatarUrl: user.avatarUrl),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl.isNotEmpty
              ? user.avatarUrl
              : 'https://i.pinimg.com/564x/59/74/d0/5974d04323d9efbaf170c72cfdb07b44.jpg',
        ),
      );
    }

    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
