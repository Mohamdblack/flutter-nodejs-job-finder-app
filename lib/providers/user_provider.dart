import 'package:flutter/material.dart';
import 'package:shaqo_plus/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    companyName: "",
    email: "",
    location: "",
    password: "",
    role: "",
    profile: "",
    token: "",
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
