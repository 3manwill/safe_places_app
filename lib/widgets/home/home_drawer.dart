import 'package:flutter/material.dart';
import 'package:safe_places_app/screens/login_screen.dart';
import 'package:safe_places_app/services/token_services.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});


  void logout(BuildContext context) {
    tokenServices.removeToken();

    Navigator.of(context).pushReplacementNamed(LoginScreen.route);
  }




  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  logout(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
