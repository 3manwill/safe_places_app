import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safe_places_app/constants/colors.dart';
import 'package:safe_places_app/widgets/login/loginForm.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary100,
      body: const Center(
        child: LoginForm(),
      )
    );
  }
}
