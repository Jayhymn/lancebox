import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lance_box/states/set_up_profile_state.dart';

class ImageUtils {
  static Future<bool> getImage(ImageSource imageSource, SetUpProfileState setUpProfileNotifier,) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      // imageQuality: 50
    );

    if (pickedFile != null) {
      setUpProfileNotifier.setUploading(UploadingState.uploading);
      Future.delayed(const Duration(seconds: 15));
      return true;
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }

      return false;
    }
  }
}
