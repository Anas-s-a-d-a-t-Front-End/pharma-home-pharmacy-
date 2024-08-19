// ignore_for_file: camel_case_types, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_home_pharmact/login_and_signup_pages/login.dart';

class custom_on_boarding_container extends StatelessWidget {
  custom_on_boarding_container({
    required this.image,
    required this.Title_text,
    required this.Body_text,
    required this.next_screen,
  });
  String? image;
  String? Title_text;
  String? Body_text;
  Widget? next_screen;
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0XFF21A06A),
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Image.asset(image!),
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => LogInPage(),
                          duration: const Duration(seconds: 2),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1, // Space between underline and text
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0, // Underline thickness
                      ))),
                      child: const Text(
                        'تخطي',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 1, // Space between underline and text
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.white,
              width: 3.0, // Underline thickness
            ))),
            child: Text(
              Title_text!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screen_width * 0.15),
            child: Text(
              Body_text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 31,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 120,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0XFF66BC89)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(next_screen,
                              duration: Duration(seconds: 3),
                              transition: Transition.rightToLeft);
                        },
                        child: Text(
                          'التالي',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 40,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
