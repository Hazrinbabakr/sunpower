import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/app/Application.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/services/local_storage_service.dart';

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 200,
            child: Image.asset("images/category/logo.png",fit: BoxFit.contain,)
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _languageButton(context,'ku'),
            const SizedBox(height: 16,),
            _languageButton(context,'en'),
            const SizedBox(height: 16,),
            _languageButton(context,'ar'),
          ],
        ),
      ),
    );
  }

  _languageButton(context,lang){
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 60,
        child: CustomAppButton(
          onTap: (){
            LocalStorageService.instance.languageCode = lang;
            Application.restartApp(context);
          },
          color: Colors.black,
          borderRadius: 15,
          elevation: 0,
          child: Center(
            child: Text(
              AppLocalizations.of(context).trans(lang),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
    );
  }
}
