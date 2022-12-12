import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/localization/AppLocal.dart';


class ProfileAvatarWidget extends StatefulWidget {
  final String name;
  final String phoneNumber;
  //bool isGuest;

  ProfileAvatarWidget({
    Key key,
    this.name,
    this.phoneNumber,
    //this.isGuest,
  }) : super(key: key);

  @override
  _ProfileAvatarWidgetState createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40,bottom: 30),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.15),
                offset: Offset(0, 6),
                blurRadius: 20)
          ]),
      child: Row(
        children: <Widget>[

          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // widget.isGuest
                  //     ? Center(
                  //       child: Text(AppLocalizations.of(context).trans("guest"),
                  //   style: Theme.of(context).textTheme.headline4.merge(
                  //         TextStyle(color: Theme.of(context).hintColor)),
                  // ),
                  //     )
                  //     :
                  Center(
                        child: Text(
                    "${widget.name.toUpperCase()}",
                    style: Theme.of(context).textTheme.subtitle1.merge(
                          TextStyle(fontSize: 22)),
                  ),
                      ),
                  SizedBox(height: 10,),
                  // widget.isGuest
                  //     ? SizedBox()
                  //     :
                  Center(
                        child: Text(widget.phoneNumber,
                    style: Theme.of(context).textTheme.subtitle1.merge(
                          TextStyle(color: Theme.of(context).hintColor)),
                  ),
                      ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: Text('Edit')
          // )
        ],
      ),
    );
  }
}
