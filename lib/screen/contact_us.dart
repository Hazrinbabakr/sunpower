import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUS extends StatefulWidget {
  const ContactUS({key}) : super(key: key);

  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: new BackArrowWidget(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 40,),
            Stack(
              children: [
                Container(
                  //color: Colors.red,
                  child: Image.asset(
                    'images/category/contactUs.png',
                    // height: 120,
                    // width: 100,
                    //width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 130,
                  child: Text(
                    AppLocalizations.of(context).trans("CONTACTSUNPOWER"),

                    style: Theme.of(context).textTheme.headline6.merge(TextStyle(
                        letterSpacing: 0, color: Theme.of(context).accentColor,fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            //launch("tel:0${7501440059}");
            // print('whatsapp');
            // launch("https://wa.link/1eanyc");


Padding(
  padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 70),
  child:   Column(

    children: [

    InkWell(
      onTap: (){
        launch("tel:0${7500777000}");
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 35,
              width: 35,
              child: Image.asset( 'images/category/phone.png',fit: BoxFit.cover,)),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            child: Text('+9640750-077-7000',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: (){
          // print('whatsapp');
           launch("https://wa.link/5ilhu5");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35,
                width: 35,
                child: Image.asset( 'images/category/whatsapp.png',fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
              child: Text('info@sunpowerc.com',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            )
          ],),
      ),
    ),
      InkWell(
        onTap: (){
          // print('whatsapp');
          // launch("https://wa.link/1eanyc");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35,
                width: 35,
                child: Image.asset( 'images/category/gmail.png',fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
              child: Text('info@sunpowerc.com',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold) ),
            )
          ],),
      ),
  ],),
)







            // Container(
            //   margin: EdgeInsets.only(left: 10,right: 10),
            //   decoration: BoxDecoration(
            //     //color: Theme.of(context).accentColor,
            //     borderRadius: BorderRadius.all(Radius.circular(5)),
            //     border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //     // boxShadow: [
            //     //   BoxShadow(
            //     //       color: Theme.of(context).focusColor.withOpacity(0.1),
            //     //       blurRadius: 15,
            //     //       offset: Offset(0, 5)),
            //     // ],
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //     child: Text('sales@bonlili.com',textAlign: TextAlign.center,),
            //   ),),










            // SizedBox(height: 10,),
            // Text(
            //    'for_any_quries_contact_bonlili',
            //     style:Theme.of(context)
            //         .textTheme
            //         .subtitle1.merge(TextStyle(color: Theme.of(context).hintColor.withOpacity(0.5)))
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
            //   child: InkWell(
            //     onTap: (){
            //       //print('phonee');
            //       launch("tel:0${7501440059}");
            //     },
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //             height: 50,
            //             width: 50,
            //             child: Image.asset('assets/img/phone-call01.png',fit: BoxFit.cover,)),
            //         Expanded(
            //           child: Container(
            //             margin: EdgeInsets.only(left: 10,right: 10),
            //             decoration: BoxDecoration(
            //               //color: Theme.of(context).accentColor,
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //               // boxShadow: [
            //               //   BoxShadow(
            //               //       color: Theme.of(context).focusColor.withOpacity(0.1),
            //               //       blurRadius: 15,
            //               //       offset: Offset(0, 5)),
            //               // ],
            //             ),
            //             child: Padding(
            //                 padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //                 child: Text('+9647501440059',textAlign: TextAlign.center,textDirection: TextDirection.ltr,)
            //             ),
            //           ),
            //         )
            //       ],),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,right: 30),
            //   child: InkWell(
            //     onTap: (){
            //       print('whatsapp');
            //       launch("https://wa.link/1eanyc");
            //     },
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //             height: 50,
            //             width: 50,
            //             child: Image.asset('assets/img/whatsapp.png',fit: BoxFit.cover,)),
            //         Expanded(
            //           child: Container(
            //             margin: EdgeInsets.only(left: 10,right: 10),
            //             decoration: BoxDecoration(
            //               //color: Theme.of(context).accentColor,
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //               // boxShadow: [
            //               //   BoxShadow(
            //               //       color: Theme.of(context).focusColor.withOpacity(0.1),
            //               //       blurRadius: 15,
            //               //       offset: Offset(0, 5)),
            //               // ],
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //               child: Text('Click_to_call',textAlign: TextAlign.center,),
            //             ),),
            //         )
            //       ],),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,right: 30,bottom: 0),
            //   child: InkWell(
            //     onTap: (){
            //       print('viber');
            //       launch("https://msng.link/o/?9647501440059=vi");
            //     },
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //             height: 50,
            //             width: 50,
            //             child: Image.asset('assets/img/viber1.png',fit: BoxFit.cover,)),
            //         Expanded(
            //           child: Container(
            //             margin: EdgeInsets.only(left: 10,right: 10),
            //             decoration: BoxDecoration(
            //               //color: Theme.of(context).accentColor,
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //               child: Text('Click_to_call',textAlign: TextAlign.center,),
            //             ),),
            //         )
            //       ],),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,right: 30),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //           height: 50,
            //           width: 50,
            //           child: Image.asset('assets/img/mail1.png',fit: BoxFit.cover,)),
            //       Expanded(
            //         child: Container(
            //           margin: EdgeInsets.only(left: 10,right: 10),
            //           decoration: BoxDecoration(
            //             //color: Theme.of(context).accentColor,
            //             borderRadius: BorderRadius.all(Radius.circular(5)),
            //             border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //             // boxShadow: [
            //             //   BoxShadow(
            //             //       color: Theme.of(context).focusColor.withOpacity(0.1),
            //             //       blurRadius: 15,
            //             //       offset: Offset(0, 5)),
            //             // ],
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //             child: Text('customercare@bonlili.com',textAlign: TextAlign.center,),
            //           ),),
            //       )
            //     ],),
            // ),
            // SizedBox(height: 40,),
            // Padding(
            //   padding: const EdgeInsets.only(right: 20,left: 20),
            //   child: Text('to_become_bonlili_product_supplie',
            //       textAlign: TextAlign.center,
            //       style:Theme.of(context)
            //           .textTheme
            //           .subtitle1.merge(TextStyle(color: Theme.of(context).hintColor.withOpacity(0.5)))
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,top: 20,right: 30),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //           height: 50,
            //           width: 50,
            //           child: Image.asset('assets/img/mail1.png',fit: BoxFit.cover,)),
            //       Expanded(
            //         child: Container(
            //           margin: EdgeInsets.only(left: 10,right: 10),
            //           decoration: BoxDecoration(
            //             //color: Theme.of(context).accentColor,
            //             borderRadius: BorderRadius.all(Radius.circular(5)),
            //             border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //             // boxShadow: [
            //             //   BoxShadow(
            //             //       color: Theme.of(context).focusColor.withOpacity(0.1),
            //             //       blurRadius: 15,
            //             //       offset: Offset(0, 5)),
            //             // ],
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //             child: Text('sales@bonlili.com',textAlign: TextAlign.center,),
            //           ),),
            //       )
            //     ],),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,right: 30,bottom: 0),
            //   child: InkWell(
            //     onTap: (){
            //       //print('phonee');
            //       launch("tel:0${7501440058}");
            //     },
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //             height: 50,
            //             width: 50,
            //             child: Image.asset('assets/img/phone-call01.png',fit: BoxFit.cover,)),
            //         Expanded(
            //           child: Container(
            //             margin: EdgeInsets.only(left: 10,right: 10),
            //             decoration: BoxDecoration(
            //               //color: Theme.of(context).accentColor,
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               border: Border.all( color: Theme.of(context).hintColor.withOpacity(0.2)),
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            //               child: Text('+9647501440058',textAlign: TextAlign.center,textDirection: TextDirection.ltr,),
            //             ),),
            //         )
            //       ],),
            //   ),
            // ),
            // SizedBox(height: 40,),
          ],),
      ),
    );
  }
}
