import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onlineshopping/Widgets/CustomAppButton.dart';
import 'package:onlineshopping/Widgets/phone_input_widget.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/auth/bussiness_user_login/bussiness_signin_page.dart';
import 'package:onlineshopping/screen/auth/providers/normal_user_login_provider.dart';
import 'package:onlineshopping/screen/auth/signup_normal_user/sign_up_main_page.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).trans("login")),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                Expanded(child: SizedBox()),
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
                          "continue",
                          //AppLocalizations.of(context).trans("continue"),
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
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return SignUpMainPage();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Register",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                SizedBox(
                  height: spacing,
                ),
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
