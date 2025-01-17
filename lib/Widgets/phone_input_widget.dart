import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sunpower/app/AppColors.dart';

class PhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) countryCode;

  const PhoneNumberInput({Key? key, required this.controller, required this.countryCode})
      : super(key: key);

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  String countryCode = '964';
  @override
  Widget build(BuildContext context) {
    NumberTextInputFormatter formatter = NumberTextInputFormatter();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  useSafeArea: true,
                  favorite: ["IQ","TR","AE"],
                  onSelect: (Country country) {
                    print('Select country: ${country.toJson()}');
                    this.widget.countryCode(country.phoneCode);
                    setState(() {
                      this.countryCode = country.phoneCode;
                    });
                  },
                );
              },
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                // ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "+${countryCode}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextFormField(
                autofocus: true,

                controller: widget.controller,
                validator: (val) {
                  String text = val!.trim().replaceAll(" ", "");
                  if (text.trim().isEmpty) {
                    return "phoneNumberEmpty";//AppLocalizations.of(context).trans("phoneNumberEmpty");
                  }
                  if (text.length < 8) {
                    return "phoneNumberInvalid";
                      //AppLocalizations.of(context).trans("phoneNumberInvalid");
                  }
                  // if (text.length == 10 && text[0] != "7") {
                  //   return "phoneNumberInvalid";
                  //     // AppLocalizations.of(context)
                  //     //   .trans("phoneNumberInvalid");
                  // }
                  // if (text.length == 11 && (text[0] != "0" || text[1] != "7")) {
                  //   return "phoneNumberInvalid";
                  //     // AppLocalizations.of(context)
                  //     //   .trans("phoneNumberInvalid");
                  // }
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
                  hintText: "xxx xxx xxx",
                  border: InputBorder.none,
                  enabledBorder:InputBorder.none,
                  focusedBorder:InputBorder.none,
                  //hintTextDirection: TextDirection.ltr,
                  // border: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey),
                  // ),
                  // enabledBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey),
                  // ),
                  // focusColor: Theme.of(context).colorScheme.primary,
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  // ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(" ", "");
    if(text.isEmpty){
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
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
