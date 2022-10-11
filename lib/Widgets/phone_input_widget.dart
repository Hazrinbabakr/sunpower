import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberInput({Key key, @required this.controller})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    NumberTextInputFormatter formatter = NumberTextInputFormatter();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              "+964",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (val) {
                String text = val.trim().replaceAll(" ", "");
                if (text.trim().isEmpty) {
                  return "phoneNumberEmpty";//AppLocalizations.of(context).trans("phoneNumberEmpty");
                }
                if (text.length < 10) {
                  return "phoneNumberInvalid";
                    //AppLocalizations.of(context).trans("phoneNumberInvalid");
                }
                if (text.length == 10 && text[0] != "7") {
                  return "phoneNumberInvalid";
                    // AppLocalizations.of(context)
                    //   .trans("phoneNumberInvalid");
                }
                if (text.length == 11 && (text[0] != "0" || text[1] != "7")) {
                  return "phoneNumberInvalid";
                    // AppLocalizations.of(context)
                    //   .trans("phoneNumberInvalid");
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                formatter
              ],
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                hintText: "7xxx xxx xxx",
                //hintTextDirection: TextDirection.ltr,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusColor: Theme.of(context).accentColor,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(" ", "");
    bool startWithZero = text[0] =='0';
    if(text.length >= 4 && text.length <= (startWithZero ? 7 : 6) ){
      String temp = "";
      if(startWithZero){
        temp = text[0]+text[1]+text[2]+text[3]+" ";
        if(text.length >= 5){
          temp+=text[4];
        }
        if(text.length >= 6){
          temp+=text[5];
        }
        if(text.length >= 7){
          temp+=text[6];
        }
      }
      else{
        temp = text[0]+text[1]+text[2]+" ";
        if(text.length >= 4){
          temp+=text[3];
        }
        if(text.length >= 5){
          temp+=text[4];
        }
        if(text.length >= 6){
          temp+=text[5];
        }
      }
      text = temp;
    } else if (text.length > (startWithZero? 7 : 6) ){
      if(startWithZero) {
        text = text[0] +
            text[1] +
            text[2] +
            text[3] +
            " " +
            text[4] +
            text[5] +
            text[6] +
            " " +
            text.substring(7);
      }
      else{
        text = text[0] +
            text[1] +
            text[2] +
            " " +
            text[3] +
            text[4] +
            text[5] +
            " " +
            text.substring(6);
      }
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
