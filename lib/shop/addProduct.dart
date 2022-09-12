// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, avoid_print, unnecessary_null_comparison


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _addProductFormKey = GlobalKey<FormState>();
   String name;
   String price;
   String desc;
   String productImgURL;
   User user;
   FirebaseAuth auth;
   var productImage;




  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        productImage = value;
        print(productImage.toString());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    user= auth.currentUser;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        // make whole screen scrollable
        child: Column(
          children: <Widget>[

            SizedBox(height: 200,),
            Container(
                height: 250,
                width: 380,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                ),
                child: (productImage==null)? FlatButton(
                  onPressed: () {
                    chooseFile();
                  },
                  child: Icon(Icons.add_a_photo),
                ): Image.file(productImage,
                    fit: BoxFit.fill)
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: _addProductFormKey,
                child: Column(
                  children: <Widget>[


                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Product Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        // icon: Icon(Icons.person),
                        labelText: 'Product Name',
                      ),
                    ),

                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          price = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Product Price!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        // icon: Icon(Icons.attach_money_sharp),
                        labelText: 'Product Price',
                      ),
                    ),



                    SizedBox(height: 49,),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.only(
                            left: 40, right: 40, bottom: 10.0, top: 10.0),
                        child: Text(
                          'Add Product',
                          style: TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        color: Colors.red[900],
                        onPressed: () async {
                          print(user.uid);
                          if (_addProductFormKey.currentState.validate()){

                            FirebaseFirestore.instance.collection('shops').doc(user.uid).collection('product').add({
                              // 'userStatus': true,
                              'categoryID': "pw9qshKXbj7bNsoqccmZ",
                              'name': name,
                              'price': price,
                              'img': productImage.toString()

                            });

                            Navigator.of(context).pop();

                          }
                        }),
//                    RaisedButton(
//                      onPressed: (){
//                        Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => Notification(),
//                        )
//                        );
//                      },
//                    ),
//


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }





}
