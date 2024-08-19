import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

class support_page extends StatelessWidget {
  const support_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تواصل معنا'),
        centerTitle: true,
        backgroundColor: Kprimary_color,
      ),
      body: Container(
        width: double.infinity,
        color: Kprimary_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 130,
              foregroundImage: AssetImage('assets/images/register_page.png'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'شركة فارما هوم (ش.م.م)',
              style: TextStyle(fontSize: 28, color: Kwhite_color),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Kwhite_color, indent: 50, endIndent: 50),
            Text(
              'موبايل : 0945405805',
              style: TextStyle(fontSize: 25, color: Kwhite_color),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Kwhite_color, indent: 50, endIndent: 50),
            Text(
              'العناون: دمشق -الجسر الابيض',
              style: TextStyle(fontSize: 25, color: Kwhite_color),
            )
          ],
        ),
      ),
    );
  }
}
