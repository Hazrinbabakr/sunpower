import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/Widgets/phone_input_widget.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/bussiness_user_login/bussiness_signin_page.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:sunpower/screen/auth/signup_normal_user/sign_up_main_page.dart';
import 'package:provider/provider.dart';

import '../../homepage.dart';
import 'login_main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    const indent = 16.0;
    const spacing = 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).trans("login")),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(

          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: indent),
            child: Column(
              children: [
                const SizedBox(
                  height: spacing,
                ),
                Row(
                  children: [
                    Text(
                        AppLocalizations.of(context).trans("WelcomeBack"),


                        //AppLocalizations.of(context).trans("welcome_back"),
                      style: TextStyle()
                    ),
                  ],
                ),
                SizedBox(height: 32,),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).trans("Mobilenumber"),
                      //AppLocalizations.of(context).trans("mobile_number"),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _form,
                  child: PhoneNumberInput(
                    controller: phoneNumberController,
                  ),
                ),
                // SizedBox(height: spacing,),
                // PrivacyPolicyWidget(),
                // Expanded(child: SizedBox()),
                SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: CustomAppButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    borderRadius: 10,
                    color: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    onTap: () {
                      if (_form.currentState.validate())
                      {
                        NormalUserLoginProvider.of(context).loginWithPhone(phone: phoneNumberController.text.trim().replaceAll(" ", ""));
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
                            fontWeight: FontWeight.w500,
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

                //register
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return SignUpMainPage();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( AppLocalizations.of(context).trans("Register"),style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                //business user
                InkWell(
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
                ),
                //skip
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return HomePage();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(  AppLocalizations.of(context).trans("skip"),style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
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
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}
