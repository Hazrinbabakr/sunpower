import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  String nameA;
  String nameK;
  String id;
  String image;

  Category({
    required this.name,
    required this.nameA,
    required this.nameK,
    required this.id,
    required this.image
  });

  factory Category.fromDoc(DocumentSnapshot doc){
    return Category(
        name: doc['name'],
        nameA: doc['nameA'],
        nameK: doc['nameK'],
        id: doc.id,
        image: doc['img']
    );
  }
}