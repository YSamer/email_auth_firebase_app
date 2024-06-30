import 'dart:developer';

import 'package:email_auth_firebase_app/core/helpers/functions/show_snackbar.dart';
import 'package:email_auth_firebase_app/providers/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login() async {
    bool success = false;
    if (formKey.currentState!.validate()) {
      setAppLoading();
      try {
        await _auth
            .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        )
            .then((user) {
          log(user.toString());
          if (user.user?.uid != null) {
            success = true;
            showSnackbar('You have successfully signed up');
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackbar('No user found for that email.', error: true);
        } else if (e.code == 'wrong-password') {
          showSnackbar('Wrong password provided for that user.', error: true);
        } else {
          log(e.toString());
        }
      } catch (e) {
        log(e.toString());
      }
      removeAppLoading();
    }
    return success;
  }
}
