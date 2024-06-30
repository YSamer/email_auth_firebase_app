import 'dart:developer';

import 'package:email_auth_firebase_app/core/helpers/functions/show_snackbar.dart';
import 'package:email_auth_firebase_app/providers/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUp() async {
    bool success = false;

    if (formKey.currentState!.validate() &&
        passwordController.text == passwordConfirmController.text) {
      setAppLoading();
      try {
        await _auth
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
            .then((user) {
          log(user.toString());
          if (user.user?.uid != null) {
            success = true;
            showSnackbar('You have successfully signed up');
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackbar('The password provided is too weak.', error: true);
        } else if (e.code == 'email-already-in-use') {
          showSnackbar(
              'The account already exists for that email.\n Please Login',
              error: true);
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
