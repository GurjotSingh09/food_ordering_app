import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/services/database.dart';
import 'package:food_delievery_app/widgets/style_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> items = ['Pizza', 'Ice-Cream', 'Burger', 'Salad'];
  String? value;
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController DetailController = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;


  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null &&
        nameController.text != "" &&
        priceController.text != "" &&
        DetailController.text != "") {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": nameController.text,
        "Price": priceController.text,
        "Detail": DetailController.text
      };
      await DatabaseMethods().addFoodItem(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Food Item has been added Successfully",
              style: TextStyle(fontSize: 18.0),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF373866),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add item',
          style: AppWidget.HeaderFieldStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload the item image',
                style: AppWidget.semiboldFieldStyle(),
              ),
              const SizedBox(
                height: 30,
              ),
              selectedImage==null?GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
              ):Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                          selectedImage!,fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Item Name',
                style: AppWidget.semiboldFieldStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: AppWidget.LightFieldStyle(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Item Price',
                style: AppWidget.semiboldFieldStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Price",
                    hintStyle: AppWidget.LightFieldStyle(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Item Details',
                style: AppWidget.semiboldFieldStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  maxLines: 6,
                  controller: DetailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Details",
                    hintStyle: AppWidget.LightFieldStyle(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select Category',
                style: AppWidget.semiboldFieldStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                                child: Text(
                              item,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )))
                        .toList(),
                    onChanged: ((value) => setState(() {
                      this.value=value;
                    })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
             const SizedBox(
               height: 30,
             ),
              GestureDetector(
                onTap: (){
                  uploadItem();
                },
                child: Center(
                  child:Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
