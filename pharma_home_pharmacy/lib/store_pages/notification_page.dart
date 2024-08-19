import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاشعارات'),
        centerTitle: true,
        backgroundColor: Kprimary_color,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoSwitch(
                value: _switch,
                onChanged: (bool value) {
                  setState(() {
                    _switch = value;
                    if (value == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            'تم تشغيل الاشعارات',
                            style:
                                TextStyle(color: Kprimary_color, fontSize: 18),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            'تم ايقاف الاشعارات',
                            style:
                                TextStyle(color: Kprimary_color, fontSize: 18),
                          ),
                        ),
                      );
                    }
                  });
                },
              ),
              Text(
                'استقبال الاشعارات',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
