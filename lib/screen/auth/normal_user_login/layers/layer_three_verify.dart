import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
import 'package:provider/provider.dart';

class LayerThreeVerify extends StatefulWidget {
  final bool register;
  final UserRegisterRequest? request;

  const LayerThreeVerify({Key? key, this.register = false,this.request})
      : super(key: key);

  @override
  _LayerThreeVerifyState createState() => _LayerThreeVerifyState();
}

class _LayerThreeVerifyState extends State<LayerThreeVerify> {
  String code = "";

  late DateTime countDownEnd;

  @override
  void initState() {
    super.initState();
    countDownEnd = DateTime.now().add(Duration(minutes: 1, seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.only(
          start: 68,
          end: 24
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 36,
          ),
          Text(
            AppLocalizations.of(context).trans("verifyYourNumber"),
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 8,),
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
                        height: (MediaQuery.of(context).size.width - 50) / 6,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary, width: 0.7
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        height: (MediaQuery.of(context).size.width - 50) / 6,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary, width: 0.7
                          ),
                        ),
                      ),
                      followingPinTheme: PinTheme(
                          height: (MediaQuery.of(context).size.width - 50) / 6,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: Colors.grey, width: 0.7
                            ),
                          )
                      ),
                      submittedPinTheme: PinTheme(
                        height: (MediaQuery.of(context).size.width - 50) / 6,
                        width: 50,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary, width: 0.7
                          ),
                        ),
                      )

                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  if (code.length == 6) {
                    NormalUserLoginProvider.of(context).manualVerification(code: code);
                  }
                },
                child: Container(
                  width: 99,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  alignment: Alignment.center,
                  child: Consumer<NormalUserLoginProvider>(
                    builder: (BuildContext context, value, child) {
                      if (value.loading) {
                        return SpinKitThreeBounce(
                          size: 18,
                          color: Colors.white,
                        );
                      }
                      return Text(
                        AppLocalizations.of(context).trans('continue'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),
                      );
                    },
                  )
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
