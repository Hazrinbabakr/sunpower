import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';

class EmptyWidget extends StatefulWidget {
  EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(Duration(seconds: 2.5.floor()), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            loading
                ? Column(
              children: [
                // SizedBox(
                //   height: screenHeight / 5,
                // ),
                Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    )),
              ],
            )
                :  Center(child: Text(AppLocalizations.of(context).trans("Empty"),))
          ],
        ),
      ),
    );
  }
}
