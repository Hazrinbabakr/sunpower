import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/providers/business_user_login.dart';
import 'package:sunpower/screen/homepage.dart';
import 'package:provider/provider.dart';

class BusinessSignInPage extends StatefulWidget {
  const BusinessSignInPage({Key? key}) : super(key: key);

  @override
  State<BusinessSignInPage> createState() => _BusinessSignInPageState();
}

class _BusinessSignInPageState extends State<BusinessSignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final BusinessUserLoginProvider _loginProvider = BusinessUserLoginProvider();
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
          Fluttertoast.showToast(msg: (_loginProvider.error as FirebaseAuthException).message??"");
        }
        else{
          Fluttertoast.showToast(msg: "Fail");
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).trans("login_business")),
        elevation: 0,
      ),
      body: ChangeNotifierProvider.value(
        value: _loginProvider,
        child: Consumer<BusinessUserLoginProvider>(
          builder: (context,value,child){
            return  GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: textFieldWidget(
                                controller: email,
                                label: AppLocalizations.of(context).trans("email"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0,),
                        Row(
                          children: [
                            Expanded(
                              child: textFieldWidget(
                                controller: password,
                                label: AppLocalizations.of(context).trans("password"),
                                password: true
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0,),
                        SizedBox(
                          width: double.infinity,
                          child: CustomAppButton(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            borderRadius: 10.0,
                            color: Theme.of(context).colorScheme.secondary,
                            elevation: 0,
                            onTap: () {
                              if(_form.currentState!.validate()){
                                BusinessUserLoginProvider.of(context).login(email: email.text, password: password.text);
                              }
                            },
                            child: Consumer<BusinessUserLoginProvider>(
                              builder: (BuildContext context, value,child) {
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  textFieldWidget(
      {required String label,
        required TextEditingController controller,
        String? hint,
        bool password = false,
        bool email = false,
        FocusNode? focusNode,
        FocusNode? next}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: password,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return AppLocalizations.of(context).trans("fieldIsRequired");
        }
        if(email){
          bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
          if(!emailValid) {
            return AppLocalizations.of(context).trans("invalid_email");
          }
        }
        return null;
      },
      inputFormatters:[
        LengthLimitingTextInputFormatter(500)
      ],
      onFieldSubmitted: (val) {
        if (next != null) {
          FocusScope.of(context).requestFocus(next);
        }
      },
      style: TextStyle(fontSize: 16),
      keyboardType: email? TextInputType.emailAddress :
          password ? TextInputType.visiblePassword :
      TextInputType.text,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
          hintStyle: TextStyle(color: Colors.grey)),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    _loginProvider.removeListener(_handleStateChange);
    super.dispose();
  }
}
