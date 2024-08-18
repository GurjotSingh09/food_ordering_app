
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delievery_app/pages/home.dart';
import 'package:food_delievery_app/services/database.dart';
import 'package:food_delievery_app/services/shared_preferences.dart';
import 'package:food_delievery_app/widgets/style_widget.dart';

class Details extends StatefulWidget {

  // const Details({super.key});

  String image, name , detail,price;
  Details({super.key, required this.detail,required this.name,required this.image,required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1 , total=0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferencesHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 2.4,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,style: AppWidget.semiboldFieldStyle(),),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (a > 1) {
                        --a;
                        total = total - int.parse(widget.price);
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    a.toString(),
                    style: AppWidget.semiboldFieldStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      ++a;
                      total = total + int.parse(widget.price);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.detail,
                style: AppWidget.LightFieldStyle(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text('Delievery Time ',
                      style: AppWidget.semiboldFieldStyle()),
                  const Icon(Icons.alarm),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '30mins',
                    style: AppWidget.semiboldFieldStyle(),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: AppWidget.semiboldFieldStyle(),
                        ),
                        Text(
                          '\$'+ total.toString(),
                          style: AppWidget.HeaderFieldStyle(),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {

                        Map<String, dynamic> addFoodtoCart = {
                          "Name": widget.name,
                          "Quantity": a.toString(),
                          "Total": total.toString(),
                          "Image": widget.image
                        };
                        await DatabaseMethods().addFoodtoCart(addFoodtoCart, id!);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.orangeAccent,
                            content: Text(
                              "Food Item has been added Successfully",
                              style: TextStyle(fontSize: 18.0),
                            )
                        ));

                      },
                      
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5)),
                        child: const Row(
                          children: [
                            Text('Add to Cart ',
                                style: TextStyle(
                                    backgroundColor: Colors.black,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Poppins')),

                            Icon(Icons.shopping_cart,color: Colors.white,),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ));
  }
}


