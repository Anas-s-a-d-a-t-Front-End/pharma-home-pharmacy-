import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/store_pages/accept_order.dart';

class confirm_order extends StatefulWidget {
  const confirm_order({super.key});

  @override
  State<confirm_order> createState() => _confirm_orderState();
}

class _confirm_orderState extends State<confirm_order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/images/confirm_order.png'),
          SizedBox(
            height: 20,
          ),
          Text(
            '.تم تقديم طلبك بنجاح',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            ' في حال عدم الرغبة بالغاء الطلب يرجى ضغط زر التاكيد',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 100,
                width: 125,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'الغاء الطلب',
                    style: TextStyle(
                        color: Kwhite_color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => accept_order(),
                      duration: Duration(seconds: 3),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  height: 100,
                  width: 125,
                  decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'تاكيد الطلب',
                      style: TextStyle(
                          color: Kwhite_color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
