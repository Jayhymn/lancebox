import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lance_box/states/set_up_state.dart';

class ImageUtils {
  static final _picker = ImagePicker();

  static Future<bool> getImage(
    ImageSource imageSource,
    SetUpState setUpProfileNotifier,
  ) async {
    try {
      final pickedFile = await _picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        setUpProfileNotifier.setUploading(UploadingState.uploading);

        await Future.delayed(const Duration(seconds: 3));

        setUpProfileNotifier.setUploading(UploadingState.uploaded);
        return true;
      } else {
        setUpProfileNotifier.setUploading(UploadingState.notUploading);
        debugPrint('No image selected.');
        return false;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      setUpProfileNotifier.setUploading(UploadingState.notUploading);
      return false;
    }
  }
}
