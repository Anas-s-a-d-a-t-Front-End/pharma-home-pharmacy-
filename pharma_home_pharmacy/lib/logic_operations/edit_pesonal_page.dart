import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:pharma_home_pharmact/const_value/constrain.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditProfilePage({required this.userData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _phoneController;
  File? _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.userData['phone']);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> updateUserData(String imageUrl) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print('No user logged in');
      return;
    }

    await FirebaseFirestore.instance
        .collection('pharmacyUser')
        .doc(userId)
        .update({
      'phone': _phoneController.text,
      'user_image': imageUrl,
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'جاري حفظ التعديلات'))); // Go back to the previous screen after updating
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> _uploadImage(File image) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('$userId.jpg');
    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    String? imageUrl;
    if (_image != null) {
      imageUrl = await _uploadImage(_image!);
    } else {
      imageUrl = widget.userData['user_image'];
    }

    await updateUserData(imageUrl!);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل الملف الشخصي'),
        backgroundColor: Kprimary_color,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  if (_image != null)
                    Center(
                      child: Image.file(
                        _image!,
                        height: 260,
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    )
                  else if (widget.userData['user_image'] != null)
                    Center(
                      child: Image.network(
                        widget.userData['user_image'],
                        height: 260,
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      primary: Kprimary_color,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'اختر صورة جديدة',
                      style: TextStyle(
                          fontSize: 18,
                          color: Kwhite_color,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    cursorColor: Kprimary_color,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 25, color: Kprimary_color),
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف',
                      labelStyle:
                          TextStyle(color: Kprimary_color, fontSize: 25),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Kprimary_color),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Kprimary_color),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      primary: Kprimary_color,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'حفظ التعديلات',
                      style: TextStyle(
                          fontSize: 18,
                          color: Kwhite_color,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
