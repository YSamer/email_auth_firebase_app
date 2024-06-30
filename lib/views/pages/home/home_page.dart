import 'package:email_auth_firebase_app/core/utilities/app_routes.dart';
import 'package:email_auth_firebase_app/providers/auth/logout_provider.dart';
import 'package:email_auth_firebase_app/views/pages/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          ChangeNotifierProvider<LogoutProvider>(
            create: (context) => LogoutProvider(),
            builder: (context, child) => Consumer<LogoutProvider>(
              builder: (context, logout, child) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await logout.logout().then((value) {
                      if (value) {
                        Future.microtask(
                          () => AppRoutes.routeRemoveAllTo(
                              context, const LoginPage()),
                        );
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home Page',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Your Email is: ${FirebaseAuth.instance.currentUser?.email}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
