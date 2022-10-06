// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/search.dart';



class HomeAppBar extends StatelessWidget {
  const HomeAppBar({ key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
//height: 200,
      //padding: EdgeInsets.only(top: 40,bottom: 30),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.15),
                offset: Offset(0, 6),
                blurRadius: 20)
          ]),      child: Padding(
        padding: const EdgeInsets.only(top: 60,bottom: 20,left: 10,right: 10),
         child:
         Center(child: Column(
           children: [
             Image.asset('images/category/logo.png',width: 200,color: Colors.white,),
             InkWell(
               onTap: () {
                 Navigator.of(context).push(SearchModal());
               },
               child: Padding(
                 padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                 child: Container(
                   height: 40,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.all(Radius.circular(6)),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 15),
                     child: Row(
                       children: [
                         Icon(Icons.search_rounded,size: 25,),
                         Text(' Search',style: TextStyle(fontSize: 17),)
                       ],
                     ),
                   ),
                 ),
               ),
             )
           ],
         )),

      ),
    );
  }
}
