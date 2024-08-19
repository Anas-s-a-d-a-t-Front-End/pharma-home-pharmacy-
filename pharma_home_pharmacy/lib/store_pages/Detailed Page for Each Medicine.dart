import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/logic_operations/cart_provider.dart';
import 'package:provider/provider.dart';

class MedicineDetailPage extends StatefulWidget {
  final String medicineId;

  MedicineDetailPage({required this.medicineId});

  @override
  State<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حول المنتج',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('allProducts')
            .doc(widget.medicineId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var medicine = snapshot.data!.data() as Map<String, dynamic>;

          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ListView(
              children: [
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Color(0Xff66BC89),
                      borderRadius: BorderRadius.circular(30)),
                  child: medicine['item_image'] != null
                      ? Image.network(
                          medicine['item_image'],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              size: 100,
                              color: Colors.grey,
                            );
                          },
                        )
                      : Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    medicine['name'] ?? 'غير متوفر',
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 30,
                        color: Kprimary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${medicine['Medication_titer'] ?? 'غير متوفر'} ملغ',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${medicine['price'] ?? 'غير متوفر'} ل.س',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (itemCount > 1) itemCount--;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(color: Kprimary_color),
                        child: Center(
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '$itemCount',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          itemCount++;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(color: Kprimary_color),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160),
                      child: Text(
                        '${medicine['old_price'] ?? 'غير متوفر'} ل.س',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 20,
                          color: Kprimary_color,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(5),
                  width: 100,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0Xff66BC89),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    medicine['description'] ?? 'لا يوجد وصف',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    var cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    cartProvider.addItem({
                      'name': medicine['name'],
                      'price': double.parse(medicine['price']),
                      'count': itemCount,
                      'image': medicine['item_image'],
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('تمت إضافة المنتج إلى السلة!'),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0Xff66BC89),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_shopping_cart,
                          color: Colors.black,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'اضف الى السلة',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
