// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:onlineshopping/Widgets/Categories.dart';
import 'package:onlineshopping/Widgets/Offers.dart';
import 'package:onlineshopping/Widgets/homeAppBar.dart';
import 'package:onlineshopping/Widgets/SocialMediaWidget.dart';
import 'package:onlineshopping/Widgets/new_arrival.dart';
import 'package:onlineshopping/localization/AppLocal.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Delivery address widget
            HomeAppBar(),
            SizedBox(
              height: 10,
            ),

            //
            // LocalStorageService.instance.user.role == 1?
            // Text('wholesale'):
            // Text('normal'),

            // Text(FirebaseAuth.instance.currentUser.uid.toString()),

            Offers(),
            SizedBox(
              height: 20,
            ),
            // CategoriesWidget(),

            //SizedBox(height: 120,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  AppLocalizations.of(context).trans("NewArrivals").toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewArrival(),
                ],
              ),
            ),

            SocialMediaWidget(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Future sendEmail() async {
  //   final smptServer = gmailSaslXoauth2(email, accessToken)
  //   final email = "hizreen.safaree@gmail.com";
  //   final token='';
  //   final message = Message()
  //     ..from = Address(email, "hizreen")
  //     ..recipients = ['hizreen.safaree@gmail.com']
  //     ..subject='Hello Hizreen'
  //     ..text= 'this is text message';
  //   try {
  //     await send(message, smptServer);
  //   } on MailerException catch (e){
  //     print(e);
  //   }
  // }

  Future<void> send() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['hizreen.safaree@gmail.com'],
      cc: ['hizreen.safaree@gmail.com'],
      bcc: ['hizreen.safaree@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
//
// Future sendEmail({
//   required String name,
//   required String email,
//   required String subject,
//   required String message,
// }) async {
//   final serviceld= 'service_85hjoxm';
//   final templateId=  'template_tiadhge';
//   final userId=  '';
//
//   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//       final response = await http.post(
//       url,
//       body: {
//       'service_id': serviceld,
//       'template_id'; templateld,
//       'user id': userId,
//       },
//       );

}

// StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance.collection('test').snapshots(),
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// print('Errorrrrr ${snapshot.error}');
// return const Text('Something went wrong');
// }
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const CircularProgressIndicator();
// }
//
// return  Container(
// height: 1000,
//
// child: ListView(
// children: snapshot.data!.docs.map((DocumentSnapshot document) {
// Map<String, dynamic> data = document.data()!;
// return ListTile(
// title: Text('ssss ${data['test1'].toString()}'),
// );
// }).toList(),
// ),
// );
// },
// ),
