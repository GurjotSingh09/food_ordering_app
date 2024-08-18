import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/pages/bottomNavigation.dart';
import 'package:food_delievery_app/pages/login.dart';
import 'package:food_delievery_app/services/shared_preferences.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';
import '../widgets/style_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "";
  String password = "";
  String name = "";

  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
          'Registration Sucessfully',
          style: TextStyle(fontSize: 20),
        )));

        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name": nameController.text,
          "Email": mailController.text,
          "Wallet": "0",
          "Id": Id,
        };
        await DatabaseMethods().addUserInfo(addUserInfo, Id);
        await SharedPreferencesHelper().saveUserName(nameController.text);
        await SharedPreferencesHelper().saveUserMail(mailController.text);
        await SharedPreferencesHelper().saveUserWallet('0');
        await SharedPreferencesHelper().saveUserId(Id);


          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNavigation()));
      } on FirebaseException catch (e) {
        if (e.code == 'Weak Password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
            'Password provided is too weak',
            style: TextStyle(fontSize: 18),
          )));
        } else if (e.code == 'email already in use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exsists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xFFff5c30),
                    Color(0xFFe74b1a),
                  ])),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              // child: Text(''),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                     'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                  )),
                  const SizedBox(
                    height: 50,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'SIGN UP ',
                              style: AppWidget.semiboldFieldStyle(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: nameController,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please Enter Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: AppWidget.semiboldFieldStyle(),
                                prefixIcon: const Icon(Icons.person_2_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: mailController,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please Enter E-mail';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: AppWidget.semiboldFieldStyle(),
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: AppWidget.semiboldFieldStyle(),
                                prefixIcon: const Icon(Icons.password_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Forgot Password ?',
                                style: AppWidget.semiboldFieldStyle(),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: ()  async {
                                if(_formkey.currentState!.validate()){
                                  setState(() {
                                    email = mailController.text;
                                    name = nameController.text;
                                    password = passwordController.text;
                                  });
                                  registration();
                                }
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFff5c30),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Already Have an Account? Log In",
                        style: AppWidget.semiboldFieldStyle(),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
