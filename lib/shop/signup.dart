// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlineshopping/shop/shopHomePage.dart';
import 'package:onlineshopping/shop/signIn.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final usersCollection = FirebaseFirestore.instance.collection('shops');
   String name;
   String phone;
   String email;
  //late String shopID;
  //late String categoryID;
   String password;
   String confirmedPassword;

  bool isPasswordConfirmed = false;
  bool hidePassword = false;
  bool hideConfirmPassword = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (BuildContext context){
            return Column(
              children: [
SizedBox(height: 100,),
                Expanded(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Form(
                        key: _signupFormKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Create Your Account',
                                style: TextStyle(
                                    fontSize: 25,
                                    //color: Colors.purple[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              validator: (val) {
                                if (val.trim().isEmpty) {
                                  return "Enter Shop Name!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Shop Name', icon: Icon(Icons.person)),
                            ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Enter Shop Email!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email', icon: Icon(Icons.person)),
                            ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  phone = val;
                                });
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Enter Your Phone Number!";
                                } else {
                                  return null;
                                }
                              },
                              controller: null,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number +964', icon: Icon(Icons.phone)),
                            ),
                            // TextFormField(
                            //   onChanged: (val) {
                            //     setState(() {
                            //       shopID = val;
                            //     });
                            //   },
                            //   validator: (val) {
                            //     if (val!.isEmpty) {
                            //       return "Enter shop shop ID!";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //
                            //   decoration: InputDecoration(
                            //       labelText: 'shopID', icon: Icon(Icons.home)),
                            // ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Enter Your Password!";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: (hidePassword) ? false : true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                icon: Icon(Icons.lock),
                                suffixIcon:  IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon:  Icon(
                                    Icons.remove_red_eye,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  confirmedPassword = val;
                                });
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Confirm Password!";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: (hideConfirmPassword) ? false : true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password!',
                                icon: Icon(Icons.lock),
                                suffixIcon:  IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hideConfirmPassword = !hideConfirmPassword;
                                    });
                                  },
                                  icon:  Icon(
                                    Icons.remove_red_eye,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40,),
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, bottom: 10.0, top: 10.0),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                                color: Colors.red[900],
                                onPressed: () async {
                                  if (password == confirmedPassword) {
                                    setState(() {
                                      isPasswordConfirmed = true;
                                    });
                                  }

                                  if (isPasswordConfirmed) {
                                    if (_signupFormKey.currentState.validate()) {
                                      try {
                                        UserCredential _result = await FirebaseAuth
                                            .instance
                                            .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                        User user = _result.user;
                                        usersCollection.doc(user.uid).set({
                                         // 'userStatus': true,
                                          'shopName': name,
                                          'phoneNum': phone,
                                          'shopEmail': email,
                                         // 'shopID': shopID,
                                          'categoryID':"0qmFmcNfuTDCzmeJwEl6",
                                          'password': password,
                                          "Date": "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                                        });
                                        if (user != null) {
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                ShopHome(shopEmail: email,),
                                          ));
                                        }
                                        print('shop added');

                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print('week pass');
                                          //Scaffold.of(context).showSnackBar(_snackBar1);
                                        } else if (e.code == 'email-already-in-use') {
                                          print('email-already-in-use');
                                         // Scaffold.of(context).showSnackBar(_snackBar2);
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  }
                                }
                              // onPressed: () async{
                              //   try {
                              //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              //         email: "barry.allen@example.com",
                              //         password: "SuperSecretPassword!"
                              //     );
                              //   } on FirebaseAuthException catch (e) {
                              //     if (e.code == 'weak-password') {
                              //       print('The password provided is too weak.');
                              //     } else if (e.code == 'email-already-in-use') {
                              //       print('The account already exists for that email.');
                              //     }
                              //   } catch (e) {
                              //     print(e);
                              //   }
                              //
                              //
                              //
                              //   // try {
                              //   //   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              //   //       email: "hiz@gmail.com",
                              //   //       password: "121212"
                              //   //   );
                              //   //   print('logged in');
                              //   // } on FirebaseAuthException catch (e) {
                              //   //   if (e.code == 'user-not-found') {
                              //   //     print('No user found for that email.');
                              //   //   } else if (e.code == 'wrong-password') {
                              //   //     print('Wrong password provided for that user.');
                              //   //   }
                              //   // }
                              // },
                                ),
                            SizedBox(height: 40,),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 50.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ));
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            );
          },
        )
    );
  }
  final _snackBar1 = SnackBar(
    content: Text(
      'The password provided is too weak',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    //backgroundColor: Colors.purple[500],
    duration: Duration(seconds: 2),
  );

  final _snackBar2 = SnackBar(
    content: Text(
      'The account already exists for that email',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    //backgroundColor: Colors.purple[500],
    duration: Duration(seconds: 2),
  );

}


