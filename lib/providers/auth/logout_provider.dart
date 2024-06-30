import 'dart:developer';

import 'package:email_auth_firebase_app/providers/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class LogoutProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> logout() async {
    bool success = false;
    setAppLoading();
    try {
      await _auth.signOut();
      success = true;
    } catch (e) {
      log(e.toString());
    }
    removeAppLoading();
    return success;
  }
}
