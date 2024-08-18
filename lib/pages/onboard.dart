import 'package:flutter/material.dart';
import 'package:food_delievery_app/pages/signUp.dart';
import 'package:food_delievery_app/widgets/style_widget.dart';

import '../widgets/content_model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding:const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                        //height =450
                          width: MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          contents[i].title,
                          style: AppWidget.semiboldFieldStyle(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          contents[i].description,
                          style: AppWidget.LightFieldStyle(),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currIndex == contents.length - 1) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              }
              _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20)
              ),
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: Text(
                  currIndex == contents.length - 1?'Start':'Next',
                  style: const TextStyle(color: Colors.white,fontSize: 25,fontFamily: 'Poppins'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currIndex == index ? 18 :9 ,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
