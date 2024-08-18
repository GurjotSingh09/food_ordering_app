import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_admin.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController username = new TextEditingController();
  TextEditingController userpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding:
                  const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 60),
              child: Form(
                  key: _formkey,
                  child:  Column(
                    children: [
                      const Text(
                        "Let's start with \n Admin",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height/2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 160, 160, 150),
                                  )
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: username,
                                    validator: (value){
                                      if(value==null ||value.isEmpty){
                                        return  "Please Enter Username";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 160, 160, 150),),),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                               Container(
                                 padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                                 margin: const EdgeInsets.symmetric(horizontal: 20),
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     border: Border.all(
                                       color: const Color.fromARGB(255, 160, 160, 150),
                                     )
                                 ),
                                 child: Center(
                                  child: TextFormField(
                                    controller: userpassword,
                                    validator: (value){
                                      if(value==null ||value.isEmpty){
                                        return  "Please Enter Password";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 160, 160, 150),),),
                                  ),
                                 ),
                               ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              GestureDetector(
                                onTap: (){
                                  LoginAdmin();
                                },
                                child: GestureDetector(
                                  onTap: (){
                                    LoginAdmin();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "LogIn",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != username.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your id is not correct",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (result.data()['password'] !=
            userpassword.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 18.0),
              )));
        } else {
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}

