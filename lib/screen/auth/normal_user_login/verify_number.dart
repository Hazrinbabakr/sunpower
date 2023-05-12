import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:provider/provider.dart';

class VerifyNumberPage extends StatefulWidget {
  final bool register;
  final UserRegisterRequest? request;

  const VerifyNumberPage({Key? key, this.register = false,this.request})
      : super(key: key);

  @override
  _VerifyNumberPageState createState() => _VerifyNumberPageState();
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  String code = "";

  late DateTime countDownEnd;

  @override
  void initState() {
    super.initState();
    countDownEnd = DateTime.now().add(Duration(minutes: 1, seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Text(
                  AppLocalizations.of(context).trans("verifyYourNumber"),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child:  Pinput(
                            length: 6,
                            keyboardType: TextInputType.number,
                            onSubmitted: (pin) {
                              print("pin");
                              //if(widget.register){
                              NormalUserLoginProvider.of(context)
                                  .manualVerification(code: pin);
                              // } else {
                              //   NormalUserLoginProvider.of(context).confirmLoginResult(
                              //       code: pin
                              //   );
                              // }
                            },
                            onChanged: (value) {
                              code = value;
                            },
                            defaultPinTheme: PinTheme(
                              height: (MediaQuery.of(context).size.width - 40) / 6,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary, width: 0.7
                                ),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              height: (MediaQuery.of(context).size.width - 40) / 6,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary, width: 0.7
                                ),
                              ),
                            ),
                            followingPinTheme: PinTheme(
                                height: (MediaQuery.of(context).size.width - 40) / 6,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.7
                                  ),
                                )
                            ),
                            submittedPinTheme: PinTheme(
                              height: (MediaQuery.of(context).size.width - 40) / 6,
                              width: 40,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary, width: 0.7
                                ),
                              ),
                            )

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(child: const SizedBox()),
                SizedBox(
                  width: double.infinity,
                  child: CustomAppButton(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      borderRadius: 10.0,
                      elevation: 0,
                      color: Theme.of(context).colorScheme.secondary,
                      onTap: () {
                        if (code.length == 6) {
                          //if (widget.register) {
                          NormalUserLoginProvider.of(context)
                              .manualVerification(code: code);
                          // } else {
                          //   NormalUserLoginProvider.of(context).confirmLoginResult(code: code);
                          // }
                        }
                      },
                      child: Consumer<NormalUserLoginProvider>(
                        builder: (BuildContext context, value, child) {
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
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Colors.white),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
