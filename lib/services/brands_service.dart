import 'package:cloud_firestore/cloud_firestore.dart';

class BrandsService {
  static List<DocumentSnapshot> _brands = [];

  static String getBrandImage(String name){
    try {
      Map brand = _brands.firstWhere((element) => element['name'] == name).data() as Map;
      return brand['img']??'';
    } catch (error){
      return '';
    }
  }

  static init() async {
    _brands = (await FirebaseFirestore.instance.collection("brands").get()).docs;
  }

  static localInit(List<DocumentSnapshot> values) async {
    _brands = values;
  }
}