import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';


class ProfileAvatarWidget extends StatefulWidget {

  final String userID;
  //bool isGuest;

  ProfileAvatarWidget({
    Key key,
    this.userID
    //this.isGuest,
  }) : super(key: key);

  @override
  _ProfileAvatarWidgetState createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  TextEditingController _textFieldController = TextEditingController();

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
              padding: const EdgeInsets.only(top: 20),
              child:

              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(widget.userID).snapshots(),
                  builder: (context, snapshot) {
                    return
                      snapshot.data==null?
                        SizedBox():
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                                child: Text(
                            "${ snapshot.data['username'].toUpperCase().toString()??''}",
                            style: Theme.of(context).textTheme.subtitle1.merge(
                                  TextStyle(fontSize: 22,color: Colors.black)),
                          ),
                              ),
                          SizedBox(height: 10,),
                          Center(
                                child: Text( snapshot.data['phone'].toString()??'',
                            style: Theme.of(context).textTheme.subtitle1.merge(
                                  TextStyle(color: Theme.of(context).hintColor)),
                          ),
                              ),
                          SizedBox(height: 10,),

                          InkWell(
                            onTap: (){
                              _textFieldController = TextEditingController(text:  snapshot.data['address'].toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Edit Your Address'),
                                      content: TextField(
                                        controller: _textFieldController,
                                        decoration: const InputDecoration(hintText: "New Address"),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text("Cancel"),
                                          onPressed: () => Navigator.pop(context),
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                )
                                            )
                                        ),
                                        ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    )
                                    )
                                    ),
                                          child: const Text('Edit'),
                                          onPressed: () {
                                           // widget.address=_textFieldController.text;
                                            FirebaseFirestore.instance
                                                .collection("users").doc(widget.userID).update({
                                              "address":  _textFieldController.text,
                                              // "subPrice": (cartInfo.data()['quantity'] +1) * cartInfo.data()['price']
                                            });
                                            Navigator.pop(context);

                                    }

                                        ),
                                      ],
                                    );
                                  });



                            },

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),                              child: Row(

                                 //crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Expanded(
                                    child: Text(snapshot.data['address'].toString()??'',
                                      style: Theme.of(context).textTheme.subtitle1,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(Icons.edit)
                                ],
                              ),
                            ),
                          ),
                        ],
                      );


                  }
              )

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
