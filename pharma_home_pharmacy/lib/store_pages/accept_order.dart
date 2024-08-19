import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/store_pages/pharmacy.dart';

class accept_order extends StatelessWidget {
  const accept_order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.done_outline_outlined,
            size: 150,
            color: Kprimary_color,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'طلبك في الطريق',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Kprimary_color),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'سيتم التواصل معكم من قبل مندوبنا لتزويدكم بوقت التوصيل',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'نشكركم على استخدام خدمة Pharma Home',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Kprimary_color),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(
                () => PharmacyHomeStorePage(),
                transition: Transition.circularReveal,
                duration: Duration(seconds: 3),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              height: 60,
              decoration: BoxDecoration(
                color: Kprimary_color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'العودة للقائمة الرئيسية',
                  style: TextStyle(fontSize: 20, color: Kwhite_color),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
