// google_sign_in_button.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/login_and_signup_pages/Requaird_information.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  Future<void> createUser() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      String message = 'Error occurred, please try again.';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'رسالة شكر',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Kprimary_color, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'شكراً لك على صبرك هذه مجرد اجراءات اولية تظهر لاول مرة فقط',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'الغاء',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.off(
                  () => RequiredInformationPage(),
                  transition: Transition.upToDown,
                  duration: Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تم انشاء الحساب بنجاح',
                      style: TextStyle(
                          color: Kprimary_color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              child: Text(
                'موافق',
                style: TextStyle(
                    fontSize: 20,
                    color: Kprimary_color,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Kprimary_color),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Stack(children: [
                ClipRRect(
                  child: Image.asset('assets/images/register_page.png'),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40)),
                ),
                Positioned(
                  left: 138,
                  top: 98,
                  child: Text(
                    'phar',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Kwhite_color),
                  ),
                ),
                Positioned(
                  left: 220,
                  top: 98,
                  child: Text(
                    'macy',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Kwhite_color),
                  ),
                )
              ]),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'التسجيل ',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  cursorColor: Kwhite_color,
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'Please enter an email.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  style: TextStyle(color: Kwhite_color, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "البريد الالكتروني",
                    labelStyle: TextStyle(
                        color: Kwhite_color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Kwhite_color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Kwhite_color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  cursorColor: Kwhite_color,
                  obscureText: _obscurePassword,
                  controller: passwordController,
                  style: TextStyle(color: Kwhite_color, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "كلمة المرور",
                    labelStyle: TextStyle(
                        color: Kwhite_color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Kwhite_color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Kwhite_color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Kwhite_color,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: createUser,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  decoration: BoxDecoration(
                    color: Kwhite_color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'انشاء حساب',
                      style: TextStyle(fontSize: 25, color: Kprimary_color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
