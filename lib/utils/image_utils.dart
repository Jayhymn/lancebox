import 'package:image_picker/image_picker.dart';
import 'package:lance_box/states/set_up_state.dart';

class ImageUtils {
  static Future<bool> getImage(
      ImageSource imageSource,
      SetUpState setUpProfileNotifier,
      ) async {
    // Pick an image
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      // Set uploading state and simulate upload
      setUpProfileNotifier.setUploading(UploadingState.uploading);

      await Future.delayed(const Duration(seconds: 3)); // Simulated upload delay

      setUpProfileNotifier.setUploading(UploadingState.uploaded); // Update to uploaded state
      return true;
    } else {
      setUpProfileNotifier.setUploading(UploadingState.notUploading);
      print('No image selected.');
      return false;
    }
  }
}
