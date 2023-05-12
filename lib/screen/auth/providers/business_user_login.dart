import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../services/local_storage_service.dart';

class BusinessUserLoginProvider extends ChangeNotifier {

  static BusinessUserLoginProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<BusinessUserLoginProvider>(context, listen: listen);


  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  dynamic error;
  bool loading = false;
  bool done = false;
  login({required String email , required String password}) async {
    try{
      error = null;
      loading = true;
      notifyListeners();
      var res = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _getUserData(email);
      done = true;
      loading = false;
      notifyListeners();
    }catch(error){
      this.error = error;
      loading = false;
      notifyListeners();
    }
  }

  _getUserData(String email) async {

    var users = await _firebaseFirestore
        .collection("users").where("email",isEqualTo: email.toLowerCase()).get();

    var res = users.size == 0 ? null : users.docs.first;

    if(res!.exists){
      LocalStorageService.instance.user = AppUser.fromJson(res.data());
    }
  }

}