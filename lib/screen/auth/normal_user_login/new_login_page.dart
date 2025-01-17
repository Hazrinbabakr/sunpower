import 'package:flutter/material.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'layers/layer_one.dart';
import 'layers/layer_three.dart';
import 'layers/layer_two.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor,Colors.black],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            tileMode: TileMode.clamp
          )
        ),
        child: SingleChildScrollView(
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
                      'images/category/logo_icon.png',
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
                        AppLocalizations.of(context).trans("WelcomeBack"),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                //const SizedBox(height: 100,),
                Expanded(
                    child: Stack(
                      children: [
                        PositionedDirectional(top: 0, end: 0, bottom: 0, child: LayerOne()),
                        PositionedDirectional(top: 30, end: 0, bottom: 10, child: LayerTwo()),
                        PositionedDirectional(top: 32, end: 0, bottom: 48, child: LayerThree()),
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
