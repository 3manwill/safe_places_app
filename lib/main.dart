import 'package:flutter/material.dart';
import 'package:safe_places_app/constants/colors.dart';
import 'package:safe_places_app/screens/home_screen.dart';
import 'package:safe_places_app/screens/image_screen.dart';
import 'package:safe_places_app/screens/login_screen.dart';
import 'package:safe_places_app/screens/place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe places',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary100),
        primaryColor: AppColor.primary,
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (context) => const HomeScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        PlaceScreen.route: (context) => const PlaceScreen(),
        ImageScreen.route: (context) => const ImageScreen()
      },
    );
  }
}
