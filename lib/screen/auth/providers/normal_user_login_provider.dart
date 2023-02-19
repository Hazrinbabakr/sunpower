import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/models/user.dart';
import 'package:sunpower/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class UserRegisterRequest {
  String name;
  String address;
  String phone;

  UserRegisterRequest(
      {@required this.name, @required this.address, @required this.phone});

  Map<String, dynamic> toJson() {
    return {"address": address, "username": name, "phone": phone, "role": 0,"email":""};
  }
}

class NormalUserLoginProvider extends ChangeNotifier {

  static NormalUserLoginProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<NormalUserLoginProvider>(context, listen: listen);


  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool loading = false;
  bool moveToSignUp = false;
  bool waitingForConfirmation = false;
  bool done = false;
  String _verificationId;
  UserRegisterRequest request;
  dynamic error;



  //ConfirmationResult confirmationResult;

  loginWithPhone({@required String phone}) async {
    try {
      error = null;
      loading = true;
      waitingForConfirmation = false;
      notifyListeners();

      if (await checkIfPhoneExist(phone: phone)) {
        verifyPhoneNumber(request: UserRegisterRequest(name: "", address: "", phone: phone));
      } else {
        moveToSignUp = true;
        loading = true;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  verifyPhoneNumber({
    @required UserRegisterRequest request,
   // @required String code,
  }) async {
    try {
      error = null;
      if(request.phone[0] == "0"){
        request.phone = request.phone.substring(1,request.phone.length);
      }
      loading = true;
      notifyListeners();
      this.request = request;

      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: "+964${request.phone}",
          //autoRetrievedSmsCodeForTesting: "111111",
          verificationCompleted: (credentials) async {
            print("verificationCompleted $credentials");
            print(credentials.verificationId);
            print(credentials.smsCode);
            print(credentials.token);
            // await _firebaseAuth.signInWithCredential(credentials);
            // await _firebaseFirestore
            //     .collection("users")
            //     .doc(_firebaseAuth.currentUser.uid)
            //     .set(request.toJson());
            // done = true;
            // notifyListeners();
          },
          verificationFailed: (FirebaseAuthException error) {
            print("verificationFailed $error");
            this.error = error;
            loading = false;
            notifyListeners();
          },
          codeSent: (id, token) {
            print("codeSent $id ,,,, $token");
            _verificationId = id;
            waitingForConfirmation = true;
            loading = false;
            notifyListeners();
          },
          codeAutoRetrievalTimeout: (id) {

          });
    } catch (error) {
      this.error = error;
      loading = false;
      notifyListeners();
    }
  }

  manualVerification({@required String code}) async {
    try {
      loading = true;
      error = null;
      notifyListeners();
      try{
        var res = await _firebaseAuth.signInWithCredential(
            PhoneAuthProvider.credential(
                verificationId: _verificationId, smsCode: code)
        );
        var doc = await _firebaseFirestore
            .collection("users")
            .doc(_firebaseAuth.currentUser.uid).get();
        if(!doc.exists){
          _firebaseFirestore
              .collection("users")
              .doc(_firebaseAuth.currentUser.uid).set(request.toJson());
        }
        done= true;
        LocalStorageService.instance.user = AppUser.fromJson(request.toJson());
        notifyListeners();
      }catch(error){
        loading = false;
        this.error = error;
        notifyListeners();
      }


    } catch (error) {}
  }

  // confirmLoginResult({@required String code}) async {
  //   if(confirmationResult != null){
  //     try{
  //       error = null;
  //       loading = true;
  //       notifyListeners();
  //       await confirmationResult.confirm(code);
  //       await _getUserData();
  //       done = true;
  //       notifyListeners();
  //     } catch (error){
  //       this.error = error;
  //       loading = false;
  //       notifyListeners();
  //     }
  //   }
  // }

  _getUserData() async {
    var res = await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser.uid).get();
    if(res.exists){
      LocalStorageService.instance.user = AppUser.fromJson(res.data());
    }
  }
  Future<bool> checkIfPhoneExist({String phone}) async {
    var res = await _firebaseFirestore
        .collection("users")
        .where("phone", isEqualTo: phone)
        .get();
    return res.size > 0;
  }
  Future<dynamic> signUp({UserRegisterRequest request}) async {
    loading = true;
    error = null;
    moveToSignUp = false;
    notifyListeners();
    if(await checkIfPhoneExist(
      phone: request.phone
    )){
      loading = false;
      error = "phone_already_exist!";
      notifyListeners();
    }
    else return verifyPhoneNumber(request: request);
  }

  handleBackButton(BuildContext context) {
    if(this.waitingForConfirmation){
      waitingForConfirmation = false;
      _verificationId = null;
      notifyListeners();
    }
    else {

    }
  }
}
