// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_home_pharmact/logic_operations/show_products_data.dart';
import 'package:pharma_home_pharmact/store_pages/Detailed%20Page%20for%20Each%20Medicine.dart';

class all_products extends StatefulWidget {
  const all_products({super.key});

  @override
  State<all_products> createState() => _all_productsState();
}

class _all_productsState extends State<all_products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'كل العناصر',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('allProducts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var product = snapshot.data!.docs[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => MedicineDetailPage(medicineId: product.id));
                  },
                  child: CustomGoodsContainer(
                    image: product['item_image'],
                    text1: product['name'],
                    text2: product['Medication_titer'] + ' ملغ',
                    text3: product['The_scientific_name'],
                    text4: product['factory_name'],
                    text5: product['Category'],
                    text6: product['price'],
                    text7: product['old_price'],
                  ),
                );
              },
            );
          },
        ),
      ]),
    );
  }
}
