import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

class CustomGoodsContainer extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;

  CustomGoodsContainer({
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Kprimary_color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(image,
                    width: 200, height: 150, fit: BoxFit.contain),
              ),
              //
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  text1,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Text(
              //     text2,
              //     style: TextStyle(fontSize: 25, color: Colors.white),
              //     textAlign: TextAlign.end,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Text(
              //     text3,
              //     style: TextStyle(fontSize: 25, color: Colors.white),
              //     textAlign: TextAlign.end,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Text(
              //     text4,
              //     style: TextStyle(fontSize: 25, color: Colors.white),
              //     textAlign: TextAlign.end,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Text(
              //     text5,
              //     style: TextStyle(fontSize: 25, color: Colors.white),
              //     textAlign: TextAlign.end,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  text6 + ' ل.س',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  text7 + 'ل.س ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
