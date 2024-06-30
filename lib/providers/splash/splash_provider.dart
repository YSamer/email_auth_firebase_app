import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  SplashProvider() {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      try {
        _authUserResult = _auth.currentUser != null;
      } catch (e) {
        _authUserResult = false;
        log(e.toString());
      }
      notifyListeners();
    });
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool? _authUserResult;
  bool? get authUserResult => _authUserResult;
}
