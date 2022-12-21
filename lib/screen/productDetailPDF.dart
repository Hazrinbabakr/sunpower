import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PdfBook extends StatefulWidget {
  String pdfUrl;
  PdfBook({this.pdfUrl,});
  @override
  _PdfBookState createState() => _PdfBookState();
}

class _PdfBookState extends State<PdfBook> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }


  loadDocument() async {
   ////// String bookUrl = widget.pdfUrl;
   //  var storagePdf = FirebaseStorage.instance.ref().child(widget.pdfUrl);
   //  String pdfUrl = await storagePdf.getDownloadURL();
    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),
       // backgroundColor: Theme.of(context).accentColor,

      ),
      body: _isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(backgroundColor: Colors.red,
            ),
            SizedBox(height: 20,),
            Text("Loading",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ],
        ),
      )
          : Container(
        color: Theme.of(context).accentColor,
        child: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
            document: document,
            scrollDirection: Axis.vertical,
            zoomSteps: 1,
            pickerIconColor: Theme.of(context).primaryColor,
            pickerButtonColor: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
