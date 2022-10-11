import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/auth/signup_normal_user/signup_normal_user.dart';
import 'package:onlineshopping/screen/homepage.dart';
import 'package:provider/provider.dart';

import '../providers/normal_user_login_provider.dart';
import '../normal_user_login/verify_number.dart';

class SignUpMainPage extends StatefulWidget {
  const SignUpMainPage({Key key}) : super(key: key);

  @override
  State<SignUpMainPage> createState() => _SignUpMainPageState();
}

class _SignUpMainPageState extends State<SignUpMainPage> {
  final NormalUserLoginProvider _loginProvider = NormalUserLoginProvider();
  List<Widget> pages = [
    SignUpPage(),
    VerifyNumberPage(register: true,)
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
      if(_loginProvider.error != null){
        if(_loginProvider.error is FirebaseAuthException){
          Fluttertoast.showToast(msg: (_loginProvider.error as FirebaseAuthException).message);
        }
        else if (_loginProvider.error is String){
          Fluttertoast.showToast(msg: AppLocalizations.of(context).trans(_loginProvider.error));
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
          //create: (context) => _loginProvider,
          value: _loginProvider,
          child: Consumer<NormalUserLoginProvider>(
            builder: (context,value,child){
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
