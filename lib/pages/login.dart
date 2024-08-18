import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food_delievery_app/pages/signUp.dart';
import 'package:food_delievery_app/widgets/style_widget.dart';

import 'bottomNavigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNavigation()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not Found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No user found for that Email",
          style: TextStyle(fontSize: 18, color: Colors.black),
        )));
      }
      else if(e.code=="Wrong Password"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
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
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Login',
                              style: AppWidget.semiboldFieldStyle(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: useremailController,
                              validator: (value){
                                if(value==null|| value.isEmpty){
                                  return 'Please enter your E-mail';
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
                              controller: userpasswordController,
                              validator: (value){
                                if(value==null|| value.isEmpty){
                                  return 'Please enter your password';
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
                              height: 70,
                            ),
                            GestureDetector(
                              onTap: (){
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    email= useremailController.text;
                                    password= userpasswordController.text;
                                  });
                                }
                                userLogin();
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
                                  child:  const Center(
                                    child: Text('Login',
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
                    height: 80,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Don't have an Account ? Sign Up",
                        style: AppWidget.semiboldFieldStyle(),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
