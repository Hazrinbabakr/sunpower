import 'package:flutter/material.dart';
import 'package:onlineshopping/localization/AppLocal.dart';

class BackArrowWidget extends StatelessWidget {
  const BackArrowWidget({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
    child: RawMaterialButton(
    onPressed: () {
    Navigator.pop(context);
    },
    elevation: 2.0,
    fillColor: Colors.white,
    child: Center(
    child: Icon(
      AppLocalizations.of(context).locale.languageCode.toString()=='en'?
    Icons.arrow_back_ios_outlined:
      Icons.arrow_forward_ios_outlined,
    size: 24.0,
      color: Colors.red[900],
    ),
    ),
    // padding: EdgeInsets.all(15.0),
    shape: CircleBorder(),
    ));
  }
}
