import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pharma_home_pharmact/category_pages/all_products.dart';
import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/custom_widgets/pesonal_file_section.dart';
import 'package:pharma_home_pharmact/login_and_signup_pages/login.dart';
import 'package:pharma_home_pharmact/store_pages/category_page.dart';

import 'package:pharma_home_pharmact/store_pages/location_page.dart';
import 'package:pharma_home_pharmact/store_pages/notification_page.dart';
import 'package:pharma_home_pharmact/store_pages/show_personal_file.dart';
import 'package:pharma_home_pharmact/store_pages/support_page.dart';

class pesonal_file extends StatelessWidget {
  const pesonal_file({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0XFF21A06A),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => LocationPage(),
                          transition: Transition.upToDown,
                          duration: Duration(seconds: 3));
                    },
                    icon: Icon(Icons.location_on),
                    color: Colors.white,
                    iconSize: 35,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 125,
                  height: 125,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0XFF21A06A),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => category_page(),
                          transition: Transition.upToDown,
                          duration: Duration(seconds: 3));
                    },
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    iconSize: 35,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => PersonalPage(),
                      duration: Duration(seconds: 3),
                      transition: Transition.rightToLeft);
                },
                child: pesonal_file_section(section_name: 'الملف الشخصي')),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => all_products(),
                      duration: Duration(seconds: 3),
                      transition: Transition.rightToLeft);
                },
                child: pesonal_file_section(section_name: 'العناصر')),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => support_page(),
                    duration: Duration(seconds: 3),
                    transition: Transition.rightToLeft);
              },
              child: pesonal_file_section(section_name: 'الدعم'),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => NotificationPage(),
                      duration: Duration(seconds: 3),
                      transition: Transition.rightToLeft);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.notifications_active),
                    Text(
                      'الاشعارات',
                      style: TextStyle(fontSize: 25, color: Kprimary_color),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.to(() => LogInPage(),
                      duration: Duration(seconds: 3),
                      transition: Transition.rightToLeft);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text(
                        'تم تسجيل الخروج بنجاح',
                        style: TextStyle(fontSize: 20, color: Kprimary_color),
                      )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/logout.png',
                        width: 30, height: 30),
                    Text(
                      'تسجيل خروج',
                      style: TextStyle(fontSize: 25, color: Kprimary_color),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
