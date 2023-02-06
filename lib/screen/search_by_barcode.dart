import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:onlineshopping/screen/productDetails.dart';

class SearchByBarcode extends StatefulWidget {
  final String barcode;

  const SearchByBarcode({Key key, this.barcode}) : super(key: key);

  @override
  State<SearchByBarcode> createState() => _SearchByBarcodeState();

  static openCamera(BuildContext context) async {
    var res = await FlutterBarcodeScanner.scanBarcode(
        "#00BCD4", "Cancel", false, ScanMode.DEFAULT);
    print("FlutterBarcodeScanner");
    print(res);
    if(res == null || res.isEmpty) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SearchByBarcode(
        barcode: res.trim().replaceAll(" ", ""),
      );
    }));
  }
}

class _SearchByBarcodeState extends State<SearchByBarcode> {
  bool noResult = false;

  @override
  void initState() {
    // print("barCode");
    // print(widget.barcode);
    // print(int.parse(widget.barcode));
    FirebaseFirestore.instance
        .collection('products')
        .where("barCode", isEqualTo: widget.barcode)
        .get()
        .then((value) {

          print(value);
          print(value.size);
      if (value.size > 0) {
        productId = value.docs.first.id;
        setState(() {

        });
        return;
      }
      noResult = true;
      setState(() {});
    }).catchError((error) {
      print(error);
      noResult = true;
      setState(() {

      });
    });
    super.initState();
  }

  var productId;

  @override
  Widget build(BuildContext context) {
    if(noResult){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Center(
          child: Text("no result")
        ),
      );
    }
    if (productId == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        ),
      );
    }
    return ProductDetails(productId);
  }
}
