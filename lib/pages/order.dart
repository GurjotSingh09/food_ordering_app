import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';
import '../services/shared_preferences.dart';
import '../widgets/style_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id, wallet;
  int total=0, amount2=0;

  void startTimer(){
    Timer(const Duration(seconds: 3), () {
      amount2=total;
      setState(() {

      });
    });
  }

  getthesharedpref()async{
    id= await SharedPreferencesHelper().getUserId();
    wallet= await SharedPreferencesHelper().getUserWallet();
    setState(() {

    });
  }

  ontheload()async{
    await getthesharedpref();
    foodStream= await DatabaseMethods().getFoodCart(id!);
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                total= total+ int.parse(ds["Total"]);
                return Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text(ds["Quantity"])),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                ds["Image"],
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Text(
                                ds["Name"],
                                style: AppWidget.semiboldFieldStyle(),
                              ),
                              Text(
                                "\$"+ ds["Total"],
                                style: AppWidget.semiboldFieldStyle(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                          "Food Cart",
                          style: AppWidget.HeaderFieldStyle(),
                        )))),
            const SizedBox(
              height: 20.0,
            ),
            Container(
                height: MediaQuery.of(context).size.height/2,
                child: foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.TextFieldStyle(),
                  ),
                  Text(
                    "\$$total",
                    style: AppWidget.semiboldFieldStyle(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: ()async{
                int amount= int.parse(wallet!)-amount2;
                await DatabaseMethods().updateUserWallet(id!, amount.toString());
                await SharedPreferencesHelper().saveUserWallet(amount.toString());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: const Center(
                    child: Text(
                      "CheckOut",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}