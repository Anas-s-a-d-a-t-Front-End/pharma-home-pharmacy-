import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:pharma_home_pharmact/logic_operations/cart_provider.dart';
import 'package:pharma_home_pharmact/login_and_signup_pages/login.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen1.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen2.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen3.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen4.dart';
import 'package:pharma_home_pharmact/splash_screen/splash_screen.dart';
import 'package:pharma_home_pharmact/welcome_page/welcome_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.ltr,
      debugShowCheckedModeBanner: false,
      home: const welcome_page(),
      getPages: [
        GetPage(name: '/welcome_page', page: () => const welcome_page()),
        GetPage(name: '/splash_screen', page: () => const SplashScreen()),
        GetPage(name: '/boarding1', page: () => const on_boarding1()),
        GetPage(name: '/boarding2', page: () => const on_boardin_page2()),
        GetPage(name: '/boarding3', page: () => const on_boarding_page3()),
        GetPage(name: '/boarding4', page: () => const on_boarding_page4()),
        GetPage(name: '/login_page', page: () => LogInPage()),
      ],
    );
  }
}
