import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/services/settings_service_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  static showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return LanguageBottomSheet();
        },
        elevation: 0.3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300 +MediaQuery.of(context).padding.bottom,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                    color: Color(0xffEBEBEB),
                    borderRadius: BorderRadius.circular(30)),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    SettingsServiceProvider.of(context).setLocale(Lang.values[index]);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).trans(Lang.values[index]),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 16,),
                        SizedBox(
                          width: 70,
                            height: 40,
                            child: Image.asset("images/flags/${Lang.values[index]}.png",fit: BoxFit.contain,))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.5,
                );
              },
              itemCount: Lang.values.length),
        ],
      ),
    );
  }
}
