import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/logic_operations/cart_provider.dart';
import 'package:pharma_home_pharmact/store_pages/confirm_order.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  Future<String> _getPharmacyName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get current user
      if (user == null) {
        return 'Unknown Pharmacy'; // Handle case when user is not logged in
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('pharmacyUser') // Correct collection name
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc['first_name'] ?? 'Unknown Pharmacy';
      } else {
        return 'Unknown Pharmacy';
      }
    } catch (e) {
      print('Failed to fetch pharmacy name: $e');
      return 'Unknown Pharmacy';
    }
  }

  Future<String> _getPharmacylocation() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get current user
      if (user == null) {
        return 'Unknown Location'; // Handle case when user is not logged in
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('pharmacyUser') // Correct collection name
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc['real_location'] ?? 'Unknown Location';
      } else {
        return 'Unknown Location';
      }
    } catch (e) {
      print('Failed to fetch pharmacy location: $e');
      return 'Unknown Location';
    }
  }

  Future<String> _getPharmacynumber() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get current user
      if (user == null) {
        return 'Unknown Phone'; // Handle case when user is not logged in
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('pharmacyUser') // Correct collection name
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc['phone'] ?? 'Unknown Phone';
      } else {
        return 'Unknown Phone';
      }
    } catch (e) {
      print('Failed to fetch pharmacy phone number: $e');
      return 'Unknown Phone';
    }
  }

  Future<void> _storeOrder(
      BuildContext context, CartProvider cartProvider) async {
    String pharmacyName = await _getPharmacyName();
    String pharmacylocation = await _getPharmacylocation();
    String pharmacyPhone = await _getPharmacynumber();

    try {
      CollectionReference orders =
          FirebaseFirestore.instance.collection('activityOrder');
      await orders.add({
        'items': cartProvider.items,
        'totalPrice': cartProvider.totalPrice,
        'location': pharmacylocation,
        'phone': pharmacyPhone,
        'first_name': pharmacyName, // Include pharmacy name in the document
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تسجيل الطلب بنجاح',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );

      Get.to(
        () => confirm_order(), // Corrected the name of the class
        transition: Transition.rightToLeftWithFade,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      print('Failed to store order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to place order. Please try again.',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          double deliveryCost = cartProvider.totalPrice * 0.3;
          double totalCost = cartProvider.totalPrice + deliveryCost;

          return Container(
            width: double.infinity,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0XFF21A06A),
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        color: Colors.white,
                        iconSize: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("الاوامر النشطة",
                        style: TextStyle(fontSize: 20, color: Kprimary_color)),
                  ],
                ),
                Divider(color: Kprimary_color),
                SizedBox(height: 20),
                cartProvider.items.isEmpty
                    ? Center(
                        child: Text(
                        'السلة فارغة',
                        style: TextStyle(
                            fontSize: 20,
                            color: Kprimary_color,
                            fontWeight: FontWeight.bold),
                      ))
                    : GridView.builder(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: cartProvider.items.length,
                        itemBuilder: (context, index) {
                          var item = cartProvider.items[index];
                          return Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Kprimary_color, width: 2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 125,
                                        padding: EdgeInsets.only(left: 5),
                                        child: item['image'] != null
                                            ? Image.network(
                                                item['image'] ?? '',
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                    Icons.image_not_supported,
                                                    size: 100,
                                                    color: Kprimary_color,
                                                  );
                                                },
                                              )
                                            : Icon(
                                                Icons.image_not_supported,
                                                size: 100,
                                                color: Kprimary_color,
                                              ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          ' ${item['price'] ?? 'غير متوفر'} ل.س',
                                          style: TextStyle(
                                              color: Kprimary_color,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        item['name'] ?? 'غير متوفر',
                                        style: TextStyle(
                                            color: Kprimary_color,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        'الكمية: ${item['count'] ?? 'غير متوفر'}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline),
                                        color: Colors.red,
                                        onPressed: () {
                                          cartProvider.removeItem(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'المجموع: ${cartProvider.totalPrice} ل.س',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'التوصيل: ${deliveryCost} ل.س',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'المجموع الكلي: ${totalCost} ل.س',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (totalCost >= 30000) {
                      _storeOrder(context, cartProvider);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'السلة فارغة يرجى تعبئة السلة والمحاولة مرة اخرى',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'اتمام عملية الشراء',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
