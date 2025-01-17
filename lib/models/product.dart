import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String nameA;
  String nameK;
  String id;
  double wholesalePrice;
  double retailPrice;
  double? oldPrice;
  double? wholesalePriceOld;
  String itemCode;
  String brand;

  List<String> image;

  Product({
    required this.name,
    required this.nameA,
    required this.nameK,
    required this.id,
    required this.image,
    required this.itemCode,
    required this.wholesalePrice,
    required this.wholesalePriceOld,
    required this.retailPrice,
    required this.brand,

    this.oldPrice
  });

  factory Product.fromDoc(DocumentSnapshot doc){
    return Product(
      name: doc['name'],
      nameA: doc['nameA'],
      nameK: doc['nameK'],
      id: doc.id,
      image: doc['images']?.map<String>((item) => item.toString()).toList(),
      itemCode: doc['itemCode'],
      wholesalePrice: doc['wholesale price']?.toDouble(),
      retailPrice: doc['retail price']?.toDouble(),
      oldPrice: doc['old price']?.toDouble(),
      brand: doc['brand'],
        wholesalePriceOld: (doc.data()! as Map)['old wholesale price']?.toDouble()??0
    );
  }

  factory Product.fromJson(Map doc){
    return Product(
        name: doc['name'],
        nameA: doc['nameA'],
        nameK: doc['nameK'],
        id: doc['productID'],
        image: (doc['images'] as List).map((e) => e.toString()).toList(),
        itemCode: doc['itemCode'],
        wholesalePrice: doc['wholesale price']?.toDouble(),
        retailPrice: doc['retail price']?.toDouble(),
        oldPrice: doc['old price']?.toDouble(),
        brand: doc['brand'],
        wholesalePriceOld: doc['old wholesale price']?.toDouble()??0
    );
  }
  get toJson => {
    'name':name,
    'nameA':nameA,
    'nameK':nameK,
    'productID':id,
    'images':image,
    'itemCode':itemCode,
    'wholesale price': wholesalePrice,
    'retail price': retailPrice,
    'old price': oldPrice,
    'old wholesale price': wholesalePriceOld,
    'brand': brand
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}