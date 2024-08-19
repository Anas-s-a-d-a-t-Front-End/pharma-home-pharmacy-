// ignore_for_file: camel_case_types, unused_import

import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/custom_widgets/custom_on_boarding_container.dart';
import 'package:pharma_home_pharmact/on_boarding_screen/on_boarding_screen4.dart';

class on_boarding_page3 extends StatefulWidget {
  const on_boarding_page3({super.key});

  @override
  State<on_boarding_page3> createState() => _on_boarding_page3State();
}

class _on_boarding_page3State extends State<on_boarding_page3> {
  @override
  Widget build(BuildContext context) {
    return custom_on_boarding_container(
        image: 'assets/images/boarding3.png',
        Title_text: 'خدمة الدفع',
        Body_text:
            'يمكنك الدفع بأي طريقة تريدها عن طريق الدفع نقدًا أو باستخدام بطاقات الائتمان',
        next_screen: on_boarding_page4());
  }
}
