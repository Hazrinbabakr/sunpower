import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/Widgets/phone_input_widget.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/app/Application.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:sunpower/screen/auth/signup_normal_user/sign_up_main_page.dart';
import '../config.dart';

class LayerThree extends StatefulWidget {

  @override
  State<LayerThree> createState() => _LayerThreeState();
}

class _LayerThreeState extends State<LayerThree> {
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  String countryCode = '964';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.only(
        start: 68,
        end: 24
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 36,
          ),
          Text(
            AppLocalizations.of(context).trans("phone"),
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 8,),
          Form(
            key: _form,
            child: PhoneNumberInput(
              controller: phoneNumberController,
              countryCode: (countryCode){
                this.countryCode = countryCode;
              },
            ),
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [


              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  if (_form.currentState!.validate())
                  {
                    NormalUserLoginProvider.of(context).loginWithPhone(
                        countryCode: countryCode,
                        phone: "${phoneNumberController.text.trim().replaceAll(" ", "")}");
                  }
                },
                child: Container(
                  width: 99,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  alignment: Alignment.center,
                  child: Consumer<NormalUserLoginProvider>(

                    builder: (BuildContext context, value, child) {
                      if (value.loading) {
                        return SpinKitThreeBounce(
                          size: 22,
                          color: Colors.white,
                        );
                      }

                      return Text(
                        AppLocalizations.of(context).trans('login'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: inputBorder,
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return SignUpMainPage();
                  }));
                },
                child: Container(
                  width: 99,
                  height: 45,
                  decoration: BoxDecoration(
                      //color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),
                      border: Border.all(
                        color: Colors.black,
                      )
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).trans("Register"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Application.restartApp(context);
                },
                child: Container(
                  width: 99,
                  height: 45,
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    ),
                    border: Border.all(
                      color: Colors.black,
                    )
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).trans("skip"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
    /*return Container(
      height: 584,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 59,
            top: 99,
            child: Text(
              'Username',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: 59,
              top: 129,
              child: Container(
                width: 310,
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter User ID or Email',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          Positioned(
            left: 59,
            top: 199,
            child: Text(
              'Password',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: 59,
              top: 229,
              child: Container(
                width: 310,
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          Positioned(
              right: 60,
              top: 296,
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 16,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600),
              )),
          *//*Positioned(
              left: 46,
              top: 361,
              child: Checkbox(
                checkColor: Colors.black,
                activeColor: checkbox,
                value: isChecked,
                onChanged: (bool? value) {
                  isChecked = value!;
                },
              )),*//*
          Positioned(
              top: 365,
              right: 60,
              child: Container(
                width: 99,
                height: 35,
                decoration: BoxDecoration(
                  color: signInButton,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
          *//*Positioned(
              top: 432,
              left: 59,
              child: Container(
                height: 0.5,
                width: 310,
                color: inputBorder,
              )),
          Positioned(
              top: 482,
              left: 120,
              right: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 59,
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(color: signInBox),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Image.asset(
                      'images/icon_google.png',
                      width: 20,
                      height: 21,
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins-Regular',
                        color: hintText),
                  ),
                  Container(
                    width: 59,
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(color: signInBox),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Image.asset(
                      'images/icon_apple.png',
                      width: 20,
                      height: 21,
                    ),
                  ),
                ],
              ))*//*
        ],
      ),
    );*/
  }
}
