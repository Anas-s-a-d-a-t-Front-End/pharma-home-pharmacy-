import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

class pesonal_file_section extends StatelessWidget {
  pesonal_file_section({this.section_name});
  String? section_name;
  Icon? section_icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back_ios),
          Text(
            '$section_name',
            style: TextStyle(fontSize: 25, color: Kprimary_color),
          ),
        ],
      ),
    );
  }
}
