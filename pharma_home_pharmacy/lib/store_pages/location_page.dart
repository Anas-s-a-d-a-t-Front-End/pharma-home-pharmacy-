import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/store_pages/pharmacy.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مواقعي '),
        centerTitle: true,
        backgroundColor: Kwhite_color,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Kprimary_color),
        child: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('User data not found.'));
            }

            // User data retrieved successfully
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            print('User Data: $userData'); // Debugging line

            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    height: 500,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/1722803225509.jpg',
                      fit: BoxFit
                          .cover, // Changed to BoxFit.cover to fill the container
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  decoration: BoxDecoration(
                    color: Kwhite_color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'موقعك الحالي : ${userData['real_location']}',
                      style: TextStyle(fontSize: 20, color: Kprimary_color),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAll(PharmacyHomeStorePage(),
                        duration: Duration(seconds: 3),
                        transition: Transition.upToDown);
                  },
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        border: Border.all(color: Kwhite_color),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'استخدم موقعك الحالي',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<DocumentSnapshot> getUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print('No user logged in'); // Debugging line
      throw Exception('User not logged in');
    }

    print('Fetching data for user ID: $userId'); // Debugging line
    return FirebaseFirestore.instance
        .collection('pharmacyUser')
        .doc(userId)
        .get();
  }
}
