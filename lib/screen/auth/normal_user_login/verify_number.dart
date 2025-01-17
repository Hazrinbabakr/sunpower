import 'package:flutter/material.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/localization/AppLocal.dart';
import '../providers/normal_user_login_provider.dart';
import 'layers/layer_one.dart';
import 'layers/layer_three_verify.dart';
import 'layers/layer_two.dart';

class VerifyNumberPage extends StatelessWidget {
  final bool register;
  final UserRegisterRequest? request;

  const VerifyNumberPage({super.key, required this.register, this.request});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.primaryColor,Colors.black],
                  //[Colors.white,AppColors.primaryColor,Colors.black],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  tileMode: TileMode.clamp
              )
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100,),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 68,
                        end: 24
                    ),
                    child: Image.asset(
                      'images/category/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 68,
                      vertical: MediaQuery.of(context).size.height * 0.01
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).trans("verification"),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Stack(
                      children: [
                        Positioned(top: 0, right: 0, bottom: 0, child: LayerOne()),
                        Positioned(top: 30, right: 0, bottom: 28, child: LayerTwo()),
                        Positioned(top: 32, right: 0, bottom: 48, child: LayerThreeVerify(
                          register: register,
                          request: request,
                        )),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
//
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sunpower/Widgets/CustomAppButton.dart';
// import 'package:sunpower/localization/AppLocal.dart';
// import 'package:sunpower/screen/auth/providers/normal_user_login_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../../Widgets/BackArrowWidget.dart';
//
// class VerifyNumberPage extends StatefulWidget {
//   final bool register;
//   final UserRegisterRequest? request;
//
//   const VerifyNumberPage({Key? key, this.register = false,this.request})
//       : super(key: key);
//
//   @override
//   _VerifyNumberPageState createState() => _VerifyNumberPageState();
// }
//
// class _VerifyNumberPageState extends State<VerifyNumberPage> {
//   String code = "";
//
//   late DateTime countDownEnd;
//
//   @override
//   void initState() {
//     super.initState();
//     countDownEnd = DateTime.now().add(Duration(minutes: 1, seconds: 30));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: BackArrowWidget(),
//         //automaticallyImplyLeading: true,
//        backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height * 0.8,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 32,
//                 ),
//                 Text(
//                   AppLocalizations.of(context).trans("verifyYourNumber"),
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Directionality(
//                         textDirection: TextDirection.ltr,
//                         child:  Pinput(
//                             length: 6,
//                             keyboardType: TextInputType.number,
//                             onSubmitted: (pin) {
//                               print("pin");
//                               //if(widget.register){
//                               NormalUserLoginProvider.of(context)
//                                   .manualVerification(code: pin);
//                               // } else {
//                               //   NormalUserLoginProvider.of(context).confirmLoginResult(
//                               //       code: pin
//                               //   );
//                               // }
//                             },
//                             onChanged: (value) {
//                               code = value;
//                             },
//                             defaultPinTheme: PinTheme(
//                               height: (MediaQuery.of(context).size.width - 40) / 6,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 border: Border.all(
//                                     color: Theme.of(context).colorScheme.primary, width: 0.7
//                                 ),
//                               ),
//                             ),
//                             focusedPinTheme: PinTheme(
//                               height: (MediaQuery.of(context).size.width - 40) / 6,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 border: Border.all(
//                                     color: Theme.of(context).colorScheme.primary, width: 0.7
//                                 ),
//                               ),
//                             ),
//                             followingPinTheme: PinTheme(
//                                 height: (MediaQuery.of(context).size.width - 40) / 6,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   border: Border.all(
//                                       color: Colors.grey, width: 0.7
//                                   ),
//                                 )
//                             ),
//                             submittedPinTheme: PinTheme(
//                               height: (MediaQuery.of(context).size.width - 40) / 6,
//                               width: 40,
//
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 border: Border.all(
//                                     color: Theme.of(context).colorScheme.primary, width: 0.7
//                                 ),
//                               ),
//                             )
//
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Expanded(child: const SizedBox()),
//                 SizedBox(
//                   width: double.infinity,
//                   child: CustomAppButton(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       borderRadius: 10.0,
//                       elevation: 0,
//                       color: Theme.of(context).colorScheme.primary,
//                       onTap: () {
//                         if (code.length == 6) {
//                           //if (widget.register) {
//                           NormalUserLoginProvider.of(context)
//                               .manualVerification(code: code);
//                           // } else {
//                           //   NormalUserLoginProvider.of(context).confirmLoginResult(code: code);
//                           // }
//                         }
//                       },
//                       child: Consumer<NormalUserLoginProvider>(
//                         builder: (BuildContext context, value, child) {
//                           if (value.loading) {
//                             return SpinKitThreeBounce(
//                               size: 22,
//                               color: Colors.white,
//                             );
//                           }
//                           return Text(
//                             AppLocalizations.of(context).trans("continue"),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           );
//                         },
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
