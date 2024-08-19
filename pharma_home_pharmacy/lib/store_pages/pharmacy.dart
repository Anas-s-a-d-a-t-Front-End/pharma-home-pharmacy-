import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

import 'package:pharma_home_pharmact/logic_operations/show_products_data.dart';
import 'package:pharma_home_pharmact/store_pages/Detailed%20Page%20for%20Each%20Medicine.dart';

import 'package:pharma_home_pharmact/store_pages/cart_page.dart';
import 'package:pharma_home_pharmact/store_pages/category_page.dart';
import 'package:pharma_home_pharmact/store_pages/location_page.dart';
import 'package:pharma_home_pharmact/store_pages/personal_file.dart';

import 'package:pharma_home_pharmact/store_pages/search_page.dart';

import 'package:pharma_home_pharmact/store_pages/show_personal_file.dart';

class PharmacyHomeStorePage extends StatefulWidget {
  @override
  _PharmacyHomeStorePageState createState() => _PharmacyHomeStorePageState();
}

class _PharmacyHomeStorePageState extends State<PharmacyHomeStorePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          buildHomePage(),
          CartPage(),
          category_page(),
        ],
      ),
    );
  }

  Widget buildHomePage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          buildHeader(),
          SizedBox(height: 20),
          buildSearchBar(),
          SizedBox(height: 20),
          buildCategoryHeader(),
          SizedBox(height: 20),
          buildProductGrid(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildLocationButton(),
        Image.asset(
          'assets/images/Group 2874.png',
          width: 125,
          height: 125,
        ),
        buildProfileButton(),
      ],
    );
  }

  Widget buildLocationButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Color(0XFF21A06A), borderRadius: BorderRadius.circular(15)),
      child: IconButton(
        onPressed: () {
          Get.to(() => LocationPage(),
              transition: Transition.downToUp, duration: Duration(seconds: 3));
        },
        icon: Icon(Icons.location_on),
        color: Colors.white,
        iconSize: 35,
      ),
    );
  }

  Widget buildProfileButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Color(0XFF21A06A), borderRadius: BorderRadius.circular(15)),
      child: IconButton(
        onPressed: () {
          Get.to(
            () => pesonal_file(), // No need to pass userId
            transition: Transition.cupertino,
            duration: Duration(seconds: 3),
          );
        },
        icon: Icon(Icons.person),
        color: Colors.white,
        iconSize: 35,
      ),
    );
  }

  Widget buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SearchPage(),
          transition: Transition.upToDown,
          duration: Duration(seconds: 3),
        );
      },
      child: Container(
          padding: EdgeInsets.only(right: 15),
          height: 60,
          decoration: BoxDecoration(
              color: Color(0XFF21A06A),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.search,
                color: Kwhite_color,
                size: 35,
              ),
              Text(
                'أبحث',
                style: TextStyle(color: Kwhite_color, fontSize: 20),
              ),
            ],
          )),
    );
  }

  Widget buildCategoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => category_page(),
                duration: Duration(seconds: 3), transition: Transition.fade);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'فئات',
              style: TextStyle(color: Color(0XFF21A06A), fontSize: 25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => CartPage(),
                duration: Duration(seconds: 3), transition: Transition.fade);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              'سلتي',
              style: TextStyle(color: Color(0XFF21A06A), fontSize: 25),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductGrid() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('allProducts').snapshots(),
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
            mainAxisSpacing: 8,
            crossAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var product = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => MedicineDetailPage(medicineId: product.id),
                    duration: Duration(seconds: 3),
                    transition: Transition.cupertino);
              },
              child: CustomGoodsContainer(
                image: product['item_image'],
                text1: product['name'],
                text2: product['Medication_titer'],
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
    );
  }
}
