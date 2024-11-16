import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileImageProvider extends ChangeNotifier {

  static ProfileImageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<ProfileImageProvider>(context, listen: listen);

  bool loading = false;
  bool done = false;
  dynamic error;

  updateImage(String link) async {
    try {
      loading = true;
      notifyListeners();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(link);
      loading = false;
      done = true;
      notifyListeners();
    } catch(error){
      print(error);
      loading = false;
      this.error = error;
      notifyListeners();
    }
  }
  deleteImage() async {
    try {
      loading = true;
      notifyListeners();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(null);
      loading = false;
      done = true;
      notifyListeners();
    } catch(error){
      print(error);
      loading = false;
      this.error = error;
      notifyListeners();
    }
  }
}