import 'package:email_auth_firebase_app/core/helpers/extensions/assetss_widgets.dart';
import 'package:email_auth_firebase_app/core/utilities/app_routes.dart';
import 'package:email_auth_firebase_app/core/utilities/app_validator.dart';
import 'package:email_auth_firebase_app/providers/auth/login_provider.dart';
import 'package:email_auth_firebase_app/views/pages/home/home_page.dart';
import 'package:email_auth_firebase_app/views/pages/signup/signup_page.dart';
import 'package:email_auth_firebase_app/views/widgets/main_button.dart';
import 'package:email_auth_firebase_app/views/widgets/main_text.dart';
import 'package:email_auth_firebase_app/views/widgets/main_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      builder: (context, child) => Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: provider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 100),
                    32.hSize,
                    MainTextField(
                      title: 'Email',
                      hint: 'Email',
                      controller: provider.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidator.emailValidate,
                      unfocusWhenTapOutside: true,
                    ),
                    16.hSize,
                    MainTextField(
                      title: 'Password',
                      hint: 'Password',
                      controller: provider.passwordController,
                      obscureText: true,
                      validator: AppValidator.passwordValidate,
                      unfocusWhenTapOutside: true,
                    ),
                    32.hSize,
                    MainButton(
                      onPressed: () async {
                        provider.login().then((value) {
                          if (value) {
                            Future.microtask(
                              () => AppRoutes.routeRemoveAllTo(
                                  context, const HomePage()),
                            );
                          }
                        });
                      },
                      child: const Center(
                        child: MainText.buttonText('Login'),
                      ),
                    ),
                    16.hSize,
                    const MainText('OR'),
                    8.hSize,
                    InkWell(
                      onTap: () {
                        AppRoutes.routeTo(context, const SignUpPage());
                      },
                      child: const MainText.textButton('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
