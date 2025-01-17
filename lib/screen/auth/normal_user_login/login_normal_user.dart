import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/Widgets/phone_input_widget.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/app/Application.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:sunpower/screen/auth/signup_normal_user/sign_up_main_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  String countryCode = '964';

  @override
  Widget build(BuildContext context) {
    const indent = 16.0;
    const spacing = 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: indent),
              child: Column(
                children: [
                  SizedBox(
                    height: spacing  + MediaQuery.of(context).size.height * 0.22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).trans("pleaseEnterYourPhoneNumberToVerifyYourAccount"),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _form,
                    child: PhoneNumberInput(
                      controller: phoneNumberController,
                      countryCode: (countryCode){
                        this.countryCode = countryCode;
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAppButton(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      borderRadius: 10,
                      color: AppColors.primaryColor,
                      elevation: 0,
                      onTap: () {
                        if (_form.currentState!.validate())
                        {
                          NormalUserLoginProvider.of(context).loginWithPhone(
                              countryCode: countryCode,
                              phone: "${phoneNumberController.text.trim().replaceAll(" ", "")}");
                        }
                      },
                      child: Consumer<NormalUserLoginProvider>(

                        builder: (BuildContext context, value, child) {
                          if (value.loading)
                            return SpinKitThreeBounce(
                              size: 22,
                              color: Colors.white,
                            );
                          return Text(
                            AppLocalizations.of(context).trans("continue"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: spacing,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return SignUpMainPage();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text( AppLocalizations.of(context).trans("Register"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87
                      ),),
                    ),
                  ),
                  //business user
                 /* InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return BusinessSignInPage();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(  AppLocalizations.of(context).trans("Businesslogin"),style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),*/
                  //skip
                  InkWell(
                    onTap: (){
                      Application.restartApp(context);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      //   return HomePage();
                      // }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(  AppLocalizations.of(context).trans("skip"),style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                    ),
                  ),
                  SizedBox(
                    height: spacing + MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black87,AppColors.primaryColor],
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(200)
                  )
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.22,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: indent,
                    top: MediaQuery.of(context).padding.top
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 150,
                          child: Image.asset('images/category/logo.png')
                      ),
                    ),
                    const SizedBox(height: indent,),
                    Text(
                      "${AppLocalizations.of(context).trans('welcome')}",
                      //"\n${AppLocalizations.of(context).trans('whatIsYourPhoneNumber')}",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "${AppLocalizations.of(context).trans('whatIsYourPhoneNumber')}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              ),
              padding: EdgeInsets.only(
                bottom: 12
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: 150,
                    child: Image.asset('images/category/logo.png')
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}
