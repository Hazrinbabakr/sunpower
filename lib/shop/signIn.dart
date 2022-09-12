// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, avoid_print, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_new


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/shop/shopHomePage.dart';
import 'package:onlineshopping/shop/signup.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {




  final _loginFormKey = GlobalKey<FormState>();

   String email;
   String password;
   FirebaseAuth _auth;
  bool hidePassword = false;
  bool isShop = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  GlobalKey<ScaffoldState> testK = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              // make whole screen scrollable
              child: Column(
                children: <Widget>[

                  SizedBox(height: 200,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                                'Login to Your Account',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                          ),
                          SizedBox(height: 60,),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter Your Email!";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: 'Email',
                            ),
                          ),
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: new Icon(
                                  Icons.remove_red_eye,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 49,),
                          RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, bottom: 10.0, top: 10.0),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              color: Colors.red[900],
                              onPressed: () async {
                                if (_loginFormKey.currentState.validate()){
                                  UserCredential _result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);

                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ShopHome(shopEmail: email,),
                                    )
                                    );

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

                          SizedBox(height: 40,),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.red[800],
                                    fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  final _snackBarnullEmail = SnackBar(
    content: Text(
      'Write Your Email!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
  );

  final _snackBarCheckEmail = SnackBar(
    content: Text(
      'Ckeck Your Email And Sign In Again',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
  );
}


