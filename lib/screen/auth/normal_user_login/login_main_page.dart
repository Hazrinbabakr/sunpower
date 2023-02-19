import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sunpower/screen/auth/normal_user_login/login_normal_user.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:sunpower/screen/auth/signup_normal_user/sign_up_main_page.dart';
import 'package:sunpower/screen/auth/normal_user_login/verify_number.dart';
import 'package:sunpower/screen/auth/signup_normal_user/signup_normal_user.dart';
import 'package:sunpower/screen/homepage.dart';
import 'package:provider/provider.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({Key key}) : super(key: key);

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {

  final NormalUserLoginProvider _loginProvider = NormalUserLoginProvider();
  List<Widget> pages = [
    LoginPage(),
    //SignUpPage(),
    VerifyNumberPage()
  ];
  initState() {
    super.initState();
    _loginProvider.addListener(_handleStateChange);
  }

  _handleStateChange() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(_loginProvider.done){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return HomePage();
        }));
      }
      if(_loginProvider.moveToSignUp){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return SignUpMainPage();
            }
        ));
      }
      if(_loginProvider.error != null){
        print(_loginProvider.error);
        if(_loginProvider.error is FirebaseAuthException){
          Fluttertoast.showToast(msg: (_loginProvider.error as FirebaseAuthException).message);
        }
        else{
          Fluttertoast.showToast(msg: "Fail");
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _loginProvider.handleBackButton(context);
      },
      child: ChangeNotifierProvider.value(
        value: _loginProvider,
        child: Consumer<NormalUserLoginProvider>(
          builder: (context,value,child){
            print(value.waitingForConfirmation ?
            1 : 0);
            return pages[
              value.waitingForConfirmation ?
                  1 : 0
            ];
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _loginProvider.removeListener(_handleStateChange);
    super.dispose();
  }
}
