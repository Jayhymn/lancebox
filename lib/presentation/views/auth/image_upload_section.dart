import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lance_box/app.dart';

import '../../../states/set_up_state.dart';
import '../../../utils/image_utils.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({
    super.key,
    required this.setUpProfileState,
    required this.setUpProfileNotifier,
  });

  final SetUpStateModel setUpProfileState;
  final SetUpState setUpProfileNotifier;

  String _getStatusLabel() {
    switch (setUpProfileState.uploadState) {
      case UploadingState.uploading:
        return "Uploading image...";
      case UploadingState.uploaded:
        return "Upload Successful";
      case UploadingState.notUploading:
        return "Drag or Select a file";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: setUpProfileState.uploadState == UploadingState.uploading
            ? null
            : () async {
                bool uploaded = await ImageUtils.getImage(
                    ImageSource.gallery, setUpProfileNotifier);
                if (uploaded) {
                  setUpProfileNotifier.setUploading(UploadingState.uploaded);
                }
              },
        child: Container(
          width: double.infinity,
          height: context.dynamicScreenHeight(120),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.transparent),
          ),
          child: CustomPaint(
            painter: DashRectPainter(
              color: AppColors.primary,
              strokeWidth: 2,
              gap: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (setUpProfileState.uploadState == UploadingState.uploading)
                  const CircularProgressIndicator()
                else if (setUpProfileState.uploadState ==
                    UploadingState.uploaded)
                  SvgPicture.asset(ImagesPaths.success, height: 40, width: 40)
                else
                  SvgPicture.asset(ImagesPaths.gallery, height: 40, width: 40),
                const SizedBox(height: 10),
                Text(
                  _getStatusLabel(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.disabled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
