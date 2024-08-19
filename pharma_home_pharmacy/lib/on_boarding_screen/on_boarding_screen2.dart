// ignore_for_file: camel_case_types, unused_import

import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/custom_widgets/custom_on_boarding_container.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen3.dart';

class on_boardin_page2 extends StatefulWidget {
  const on_boardin_page2({super.key});

  @override
  State<on_boardin_page2> createState() => _on_boardin_page2State();
}

class _on_boardin_page2State extends State<on_boardin_page2> {
  @override
  Widget build(BuildContext context) {
    return custom_on_boarding_container(
      image: 'assets/images/boarding2.png',
      Title_text: 'تصفح الطب من الفئات',
      Body_text:
          'يمكنك اختيار نوع الدواء الذي تريده من خلال تصفح الفئات الموجودة أو من خلال البحث عنها',
      next_screen: on_boarding_page3(),
    );
  }
}
