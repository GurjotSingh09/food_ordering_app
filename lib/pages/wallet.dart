import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delievery_app/widgets/style_widget.dart';

import '../services/database.dart';
import '../services/shared_preferences.dart';
import '../widgets/app_constant.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController amountcontroller = new TextEditingController();

  getthesharedpref() async {
    wallet = await SharedPreferencesHelper().getUserWallet();
    id = await  SharedPreferencesHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: wallet==null?Center(child: CircularProgressIndicator()) : Container(
          margin: EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                        child: Text(
                          "Wallet",
                          style: AppWidget.HeaderFieldStyle(),
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/wallet.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Wallet',style: AppWidget.LightFieldStyle()),
                        const SizedBox(
                            height:10
                        ),
                        Text("\$" +wallet!,style: AppWidget.semiboldFieldStyle(),),
                        // Text('\$'+ wallet!,style: AppWidget.semiboldFieldStyle(),),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Add Money',style: AppWidget.semiboldFieldStyle(),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      makePayment('100');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text( "\$"+'100',style: AppWidget.semiboldFieldStyle(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment('500');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text( "\$"+'500',style: AppWidget.semiboldFieldStyle(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment('1000');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text( "\$"+ '1000',style: AppWidget.semiboldFieldStyle(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment('2000');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text( "\$"+ '2000',style: AppWidget.semiboldFieldStyle(),),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: (){
                  openEdit();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    color: Color(0xFF008080),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text("Add Money",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        )
    );
  }
  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Gurjot'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }
  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);
        await SharedPreferencesHelper().saveUserWallet(add.toString());
        await DatabaseMethods().updateUserWallet(id!, add.toString());
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        await getthesharedpref();
        // ignore: use_build_context_synchronously

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;

    return calculatedAmount.toString();
  }

  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel)),
                    const SizedBox(
                      width: 60.0,
                    ),
                    const Center(
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                          color: Color(0xFF008080),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text("Amount"),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: amountcontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Enter Amount'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      makePayment(amountcontroller.text);
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFF008080),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}