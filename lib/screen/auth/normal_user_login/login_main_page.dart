import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sunpower/screen/auth/normal_user_login/new_login_page.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:sunpower/screen/auth/signup_normal_user/sign_up_main_page.dart';
import 'package:sunpower/screen/auth/normal_user_login/verify_number.dart';
import 'package:sunpower/screen/homepage.dart';
import 'package:provider/provider.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({Key? key}) : super(key: key);

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {

  final NormalUserLoginProvider _loginProvider = NormalUserLoginProvider();
  List<Widget> pages = [
    LoginPage(),
    //SignUpPage(),
    VerifyNumberPage(register: false,)
  ];
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loginProvider.addListener(_handleStateChange);
    });

  }

  _handleStateChange() {
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
        if(_loginProvider.error is FirebaseAuthException){
          Fluttertoast.showToast(msg: (_loginProvider.error as FirebaseAuthException).message??"");
        }
        else{
          Fluttertoast.showToast(msg: "Fail");
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        _loginProvider.handleBackButton(context);
      },
      canPop: false,
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
