import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectService {

  static Future<String?> selectImage() async {
    try {
      ImagePicker picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      var compressed = await compressImage(image.path);
      if (compressed == null) {
        return null;
      }
      FirebaseStorage storage = FirebaseStorage.instance;
      var ref = storage.ref("profile").child(
          "${FirebaseAuth.instance.currentUser!.uid}.jpeg");
      await ref.putData(compressed);
      return await ref.getDownloadURL();
    }
    catch(error){
      print(error);
      return null;
    }
  }

  static Future<Uint8List?> compressImage(String filePath) async {
    Uint8List?  compressedImage = await FlutterImageCompress.compressWithFile(filePath,minHeight: 512,minWidth: 512);
    return compressedImage;
  }
}
