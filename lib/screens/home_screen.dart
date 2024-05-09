import 'package:flutter/material.dart';
import 'package:safe_places_app/constants/colors.dart';
import 'package:safe_places_app/models/results/identity_result.dart';
import 'package:safe_places_app/screens/login_screen.dart';
import 'package:safe_places_app/services/identity_services.dart';
import 'package:safe_places_app/widgets/public/future_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';
  const HomeScreen({super.key});

  Future<void> _checkAuth(BuildContext context) async {
    IdentityResult identityResult = await identityServices.authorization();

    if (identityResult.status == ResponseStatus.unauthorized) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureWidget<void>(
        future: _checkAuth(context),
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        successBuilder: (_) {
          return Container(
            color: AppColor.primary100,
            child: const Center(
              child: Text('home page'),
            ),
          );
        },
        errorBuilder: (ex) {
          return const Expanded(
            child: Center(child: Text('Error')),
          );
        },
      ),
    );
  }
}
