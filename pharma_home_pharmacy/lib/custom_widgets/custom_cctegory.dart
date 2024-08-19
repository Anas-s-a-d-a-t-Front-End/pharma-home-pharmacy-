// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

class coustm_category_container extends StatelessWidget {
  coustm_category_container(
      {required this.category_image, required this.category_name});
  String? category_image;
  String? category_name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Kprimary_color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(category_image!),
          SizedBox(
            height: 20,
          ),
          Text(
            category_name!,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
