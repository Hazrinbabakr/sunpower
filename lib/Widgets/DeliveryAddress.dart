// ignore_for_file: file_names

import 'package:flutter/material.dart';



class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({ key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
      child:  Row(children:  [
        const  Icon(Icons.location_on,color: Colors.red,size: 35,),
        const SizedBox(width: 3,),
        Column(
          children: const [
            Text('Delivery to ',style: TextStyle(fontSize: 13),),
            Text('Unknown',style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
          ],
        ),
        const Spacer(),
        const  Icon(Icons.notifications_none_rounded,color: Colors.black54,size: 35,),
      ],),
    );
  }
}
