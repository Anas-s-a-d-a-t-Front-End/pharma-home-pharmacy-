import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home_pharmact/const_value/constrain.dart';
import 'package:pharma_home_pharmact/login_and_signup_pages/signUp.dart';
import 'package:pharma_home_pharmact/store_pages/pharmacy.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true; // Password visibility state

  Future<void> signInUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Fetch user data from Firestore
        final userEmail = emailController.text;
        final userDoc = await FirebaseFirestore.instance
            .collection('pharmacyUser')
            .where('email', isEqualTo: userEmail)
            .limit(1)
            .get();

        if (userDoc.docs.isNotEmpty) {
          final userData = userDoc.docs.first.data();
          final docId = userDoc.docs.first.id;

          // Navigate to PharmacyHomeStorePage
          Get.offAll(() => PharmacyHomeStorePage(),
              transition: Transition.fade, duration: Duration(seconds: 3));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User data not found.')));
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'User not found';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password';
        } else {
          errorMessage = 'An error occurred. Please try again';
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                      'تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUpPage(),
                              transition: Transition.fade,
                              duration: Duration(seconds: 3));
                        },
                        child: Text(
                          'سجل هنا',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        ' ,اذا لم يكن لديك حساب',
                        style: TextStyle(color: Kwhite_color, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: Kwhite_color,
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'الرجاء ادخال بريد الكتروني';
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'الرجاء ادخال كلمة مرور';
                        }
                        return null;
                      },
                      cursorColor: Kwhite_color,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: _obscurePassword,
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
                    onTap: () => signInUser(context),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 75),
                      decoration: BoxDecoration(
                        color: Kwhite_color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        'المتابعة',
                        style: TextStyle(fontSize: 25, color: Kprimary_color),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Kwhite_color),
              ),
            ),
        ],
      ),
    );
  }
}
