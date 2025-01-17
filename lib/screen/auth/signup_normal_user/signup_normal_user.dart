import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/Widgets/phone_input_widget.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController address = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  String countryCode = '964';

  @override
  Widget build(BuildContext context) {

    const indent = 16.0;
    const spacing = 20.0;
    //BackArrowWidget();
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).trans("signup"),style: TextStyle(color: Colors.black87),),
        leading: BackArrowWidget(),
        elevation: 0,
        centerTitle: true,
      ),*/
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // onTap: (){
            //   FocusScope.of(context).unfocus();
            // },
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
                      SizedBox(
                        height: spacing  + MediaQuery.of(context).size.height * 0.22,
                      ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).trans("phone"),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const SizedBox(height: 4,),
                          PhoneNumberInput(
                            controller: phoneNumberController,
                            countryCode: (countryCode){
                              setState(() {
                                this.countryCode = countryCode;
                              });
                            },
                          ),
                        ],
                      ),
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
                          color: Theme.of(context).colorScheme.primary,
                          elevation: 0,
                          onTap: () {
                            if(_form.currentState!.validate()){
                              NormalUserLoginProvider.of(context).signUp(
                                request: UserRegisterRequest(
                                  name: name.text.trim(),
                                  address: address.text.trim(),
                                  phone: phoneNumberController.text.replaceAll(" ", "").trim(),
                                    countryCode: countryCode
                              ),);
                            }
                          },
                          child: Consumer<NormalUserLoginProvider>(
                            builder: (BuildContext context, value,child) {
                              if (value.loading) {
                                return SpinKitThreeBounce(
                                  size: 22,
                                  color: Colors.white,
                                );
                              }
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
                    SizedBox(
                      height: 30,
                      child: Stack(
                        children: [
                          BackButton(
                            color: Colors.white,
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                height: 30,
                                child: Image.asset('images/category/logo.png')
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: indent*2,),
                    Row(
                      children: [
                        Text(
                          "${AppLocalizations.of(context).trans('registerYourAccount')}",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  textFieldWidget(
      {required String label,
        required TextEditingController controller,
        String? hint,
        FocusNode? focusNode,
        FocusNode? next}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 4,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.2
              ),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(15),
                bottomEnd: Radius.circular(15),
              )
          ),
          padding: EdgeInsets.all(8),

          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   borderRadius: BorderRadiusDirectional.only(
          //     bottomEnd: Radius.circular(25),
          //     topStart: Radius.circular(25),
          //   )
          // ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            validator: (text) {
              if (text!.trim().isEmpty) {
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
              border: InputBorder.none
                // prefixIcon: Align(
                //   alignment: AlignmentDirectional.centerStart,
                //   child: Text(
                //     label,
                //     style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w300
                //     ),
                //   ),
                // ),
                // prefixText: label,
                // prefixStyle: TextStyle(
                //     color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300
                // ),
                // enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey)
                // ),
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey)
                // ),
                // focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
                // ),
                // hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
        ),
      ],
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
