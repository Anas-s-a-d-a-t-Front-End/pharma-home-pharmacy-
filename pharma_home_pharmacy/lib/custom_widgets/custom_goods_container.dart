import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/store_pages/pharmacy.dart';

class GoodsContainers extends StatefulWidget {
  @override
  _GoodsContainersState createState() => _GoodsContainersState();
}

class _GoodsContainersState extends State<GoodsContainers> {
  TextEditingController nameController = TextEditingController();
  TextEditingController scienceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController factoryNameController = TextEditingController();
  TextEditingController medicationTiterController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey formKey = GlobalKey();
  String imageUrl = '';
  String dropdownValue = 'دواء';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'أضافة منتج جديد',
                  style: TextStyle(
                    color: Kprimary_color,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                    image: imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('${file!.path}');
                      if (file == null) return;
                      String uniqueFilename =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDir =
                          referenceRoot.child('products_image');

                      Reference referenceImageToUpload =
                          referenceDir.child(uniqueFilename);

                      try {
                        await referenceImageToUpload.putFile(File(file.path));

                        String downloadUrl =
                            await referenceImageToUpload.getDownloadURL();

                        setState(() {
                          imageUrl = downloadUrl;
                        });
                      } on Exception {
                        // Handle exception
                      }
                    },
                    icon: Icon(Icons.camera_enhance_rounded),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'أسم الدواء',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: scienceNameController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'التركيب العلمي',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: medicationTiterController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'العيار الطبي',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: categoryController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'التصنيف',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'السعر',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: oldPriceController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'السعر القديم',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: factoryNameController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'اسم المصنع',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: descriptionController,
                  style: TextStyle(fontSize: 20, color: Kprimary_color),
                  textAlign: TextAlign.end,
                  cursorColor: Kprimary_color,
                  decoration: InputDecoration(
                    hintText: 'شرح عن المنتج ',
                    hintStyle: TextStyle(fontSize: 20, color: Kprimary_color),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Kprimary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      value: 'دواء',
                      child: Text('دواء'),
                    ),
                    DropdownMenuItem(
                      value: 'مستحضرات تجميل',
                      child: Text('مستحضرات تجميل'),
                    ),
                    DropdownMenuItem(
                      value: 'العطور',
                      child: Text('العطور'),
                    ),
                    DropdownMenuItem(
                      value: 'مستحضرات طبيعية',
                      child: Text('مستحضرات طبيعية'),
                    ),
                    DropdownMenuItem(
                      value: 'مكملات رياضية',
                      child: Text('مكملات رياضية'),
                    ),
                    DropdownMenuItem(
                      value: 'عناية بالشعر',
                      child: Text('عناية بالشعر'),
                    ),
                    DropdownMenuItem(
                      value: 'أجهزة طبية',
                      child: Text('أجهزة طبية'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  value: dropdownValue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please upload product image')));
                    return;
                  }
                  Map<String, dynamic> dataToSave = {
                    'name': nameController.text,
                    'The_scientific_name': scienceNameController.text,
                    'Medication_titer': medicationTiterController.text,
                    'Category': categoryController.text,
                    'price': priceController.text,
                    'old_price': oldPriceController.text,
                    'factory_name': factoryNameController.text,
                    'item_image': imageUrl,
                    'item_category': dropdownValue,
                    'description': descriptionController.text
                  };

                  FirebaseFirestore.instance
                      .collection('allProducts')
                      .add(dataToSave);

                  Get.offAll(() => PharmacyHomeStorePage(),
                      duration: Duration(seconds: 3),
                      transition: Transition.leftToRight);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("تمت اضافة منتج جديد بنجاح"),
                    duration: Duration(seconds: 6),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Kprimary_color),
                  child: Center(
                      child: Text(
                    'أضافة',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
