import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/pages/details.dart';
import 'package:food_delievery_app/services/database.dart';
import 'package:food_delievery_app/widgets/style_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool pizza = false, iceCream = false, burger = false, salad = false;

  Stream? fooditemStream;

  Ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    Ontheload();
    super.initState();
  }

  Widget allItem() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
               padding: EdgeInsets.zero ,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                 DocumentSnapshot ds = snapshot.data.docs[index];
                 return GestureDetector(
                   onTap: () {
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],image: ds["Image"],price: ds["Price"],)));
                   },
                   child: Container(
                     margin: const EdgeInsets.all(4),
                     child: Material(
                       elevation: 5,
                       borderRadius: BorderRadius.circular(20),
                       child: Container(
                         padding: const EdgeInsets.all(14),
                         child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(20),
                                 child: Image.network(
                                   ds["Image"],
                                   height: 150,
                                   width: 150,
                                   fit: BoxFit.fill,
                                 ),
                               ),
                               Text(
                                 ds["Name"],
                                 style: AppWidget.semiboldFieldStyle(),
                               ),
                               const SizedBox(
                                 height: 5,
                               ),
                               Text(
                                 'Fresh and Healthy',
                                 style: AppWidget.LightFieldStyle(),
                               ),
                               const SizedBox(
                                 height: 5,
                               ),
                               Text(
                                 '\$'+ ds["Price"],
                                 style: AppWidget.semiboldFieldStyle(),
                               )
                             ]),
                       ),
                     ),
                   ),
                 );

              })
              : Center(
              widthFactor: 10,
              child: CircularProgressIndicator());
        });
  }

  Widget allItemVeritcal() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.zero ,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],image: ds["Image"],price: ds["Price"],)));
                  },
                  child:Container(
                    margin: const EdgeInsets.only(right: 15,bottom: 15),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              ds["Image"],
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ds["Name"],
                                    style: AppWidget.semiboldFieldStyle(),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ds["Detail"],
                                    style: AppWidget.LightFieldStyle(),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    '\$'+ ds["Price"],
                                    style: AppWidget.semiboldFieldStyle(),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              })
              : const Center(
              widthFactor: 10,
              child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello,Gurjot', style: AppWidget.TextFieldStyle()),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Delicious Food ', style: AppWidget.HeaderFieldStyle()),
              Text('Discover and Get Great Food.',
                  style: AppWidget.LightFieldStyle()),
              const SizedBox(
                height: 20,
              ),
              // for show Item
              Container(
                  margin: const EdgeInsets.only(right: 20), child: showItem()),
              const SizedBox(
                height: 30,
              ),

              Container(
                height: 270,
                  child: allItem()),

              const SizedBox(
                height: 30,
              ),
              allItemVeritcal(),


            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            pizza = true;
            iceCream = false;
            burger = false;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/pizza.png',
                height: 40,
                width: 40,
                fit: BoxFit.fill,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () async {
            burger = true;
            pizza = false;
            iceCream = false;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/burger.png',
                height: 40,
                width: 40,
                fit: BoxFit.fill,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () async{
            iceCream = true;
            pizza = false;
            burger = false;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Ice-Cream");
            setState(() {});
          },
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: iceCream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/ice-cream.png',
                height: 40,
                width: 40,
                fit: BoxFit.fill,
                color: iceCream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),


        GestureDetector(
          onTap: () async{
            salad = true;
            pizza = false;
            iceCream = false;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/salad.png',
                height: 40,
                width: 40,
                fit: BoxFit.fill,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
