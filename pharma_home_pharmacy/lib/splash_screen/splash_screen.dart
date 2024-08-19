import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:pharma_home_pharmact/login_and_signup_pages/login.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen1.dart';
import 'package:pharma_home_pharmact/store_pages/pharmacy.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<Widget> _getNextScreen() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return PharmacyHomeStorePage(); // Navigate to the RepositoryPage if logged in
    } else {
      return on_boarding1(); // Navigate to the LogInPage if not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getNextScreen(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return AnimatedSplashScreen(
            splashIconSize: double.infinity,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.bottomToTop,
            animationDuration: const Duration(seconds: 2),
            splash: Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
            ),
            nextScreen:
                snapshot.data!, // Navigate to the determined next screen
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
