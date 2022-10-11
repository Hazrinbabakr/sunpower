import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onlineshopping/Widgets/CustomAppButton.dart';
import 'package:onlineshopping/Widgets/phone_input_widget.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/auth/providers/normal_user_login_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController address = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).trans("signup")),
        elevation: 0,
        centerTitle: true,
      ),
      body: GestureDetector(
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
                          controller: name,
                          label: AppLocalizations.of(context).trans("name"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0,),
                  PhoneNumberInput(controller: phoneNumberController),
                  const SizedBox(height: 16.0,),
                  Row(
                    children: [
                      Expanded(
                        child: textFieldWidget(
                          controller: address,
                          label: AppLocalizations.of(context).trans("address"),
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
                        if(_form.currentState.validate()){

                          NormalUserLoginProvider.of(context).signUp(
                            request: UserRegisterRequest(
                              name: name.text.trim(),
                              address: address.text.trim(),
                              phone: phoneNumberController.text.replaceAll(" ", "").trim()
                          ),);
                        }
                      },
                      child: Consumer<NormalUserLoginProvider>(
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
      ),
    );
  }

  textFieldWidget(
      {@required String label,
        @required TextEditingController controller,
        String hint,
        FocusNode focusNode,
        FocusNode next}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: (text) {
        if (text.trim().isEmpty) {
          return AppLocalizations.of(context).trans("fieldIsRequired");
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

      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor)),
          hintStyle: TextStyle(color: Colors.grey)),
    );
  }

  @override
  void dispose() {
    name.dispose();
    phoneNumberController.dispose();
    address.dispose();
    super.dispose();
  }
}
