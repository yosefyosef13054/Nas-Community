import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class ImagePickService {
  ImagePickService._();


  static Future<XFile?> pickImageGallery() async {
    try{
      final ImagePicker _picker = ImagePicker();
     final XFile? result = await _picker.pickImage(source: ImageSource.gallery);
     return result;
    }catch (e){
      log("Failed to pick image : ${e.toString()}");
      rethrow;
    }
  }


  static Future<XFile?> pickImageCamera () async {
    try{
      final ImagePicker _picker = ImagePicker();
      final XFile? result = await _picker.pickImage(source: ImageSource.camera);
      return result;
    }catch (e){
      log("Failed to pick image : ${e.toString()}");
      rethrow;
    }
  }
}