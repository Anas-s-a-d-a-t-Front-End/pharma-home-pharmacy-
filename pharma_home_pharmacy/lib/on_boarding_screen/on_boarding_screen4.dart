// ignore_for_file: camel_case_types, unused_import

import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/custom_widgets/custom_on_boarding_container.dart';
import 'package:pharma_home_pharmact/login_and_signup_pages/login.dart';

class on_boarding_page4 extends StatefulWidget {
  const on_boarding_page4({super.key});

  @override
  State<on_boarding_page4> createState() => _on_boarding_page4State();
}

class _on_boarding_page4State extends State<on_boarding_page4> {
  @override
  Widget build(BuildContext context) {
    return custom_on_boarding_container(
        image: 'assets/images/boarding4.png',
        Title_text: 'خدمة التوصيل',
        Body_text: 'يمكنك الحصول على طلبك بسرعة كبيرة وفي نفس اليوم',
        next_screen: LogInPage());
  }
}
