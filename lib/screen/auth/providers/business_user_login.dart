import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessUserLoginProvider extends ChangeNotifier {

  static BusinessUserLoginProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<BusinessUserLoginProvider>(context, listen: listen);


  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  dynamic error;
  bool loading = false;
  bool done = false;
  login({@required String email , @required String password}) async {
    try{
      error = null;
      loading = true;
      notifyListeners();
      var res = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      done = true;
      loading = false;
      notifyListeners();
    }catch(error){
      this.error = error;
      loading = false;
      notifyListeners();
    }
  }

}