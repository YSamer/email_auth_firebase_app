import 'package:email_auth_firebase_app/core/utilities/app_routes.dart';
import 'package:email_auth_firebase_app/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider get get => Provider.of<AppProvider>(AppNavigator.context);
  static AppProvider get getFalse =>
      Provider.of<AppProvider>(AppNavigator.context, listen: false);

  void removeAllAppLoading() {
    isLoading = 0;
    notifyListeners();
  }

  int isLoading = 0;

  void setAppLoading() {
    isLoading = isLoading + 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  void removeAppLoading({bool all = false}) {
    if (isLoading > 0) {
      isLoading = 0;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}

void setAppLoading() => AppProvider.getFalse.setAppLoading();
void removeAppLoading() => AppProvider.getFalse.removeAppLoading();
