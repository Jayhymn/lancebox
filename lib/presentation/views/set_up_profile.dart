import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';
import 'package:lance_box/presentation/widgets/default_button_2.dart';
import 'package:lance_box/states/set_up_profile_state.dart';

import '../../utils/image_utils.dart';
import '../widgets/dashed_rect_painter.dart';

class SetUpProfile extends ConsumerWidget {
  const SetUpProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the selected option from Riverpod
    final setUpProfileState = ref.watch(setupProfileProvider);
    final setUpProfileNotifier = ref.watch(setupProfileProvider.notifier);

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagesPaths.appIcon,
                height: 40,
                width: 40,
              ),
              SizedBox(height: context.sizeHeight(0.05)),
              Text(
                "Let's get to know you better",
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: context.dynamicScreenHeight(20)),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Set up Profile',
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      WidgetSpan(
                        child: SvgPicture.asset(
                          ImagesPaths.forwardArrow,
                        ),
                      ),
                      TextSpan(
                          text: ' Personal Details ',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.disabled)),
                      WidgetSpan(
                        child: Opacity(
                          opacity: 0.3,
                          child: SvgPicture.asset(
                            ImagesPaths.forwardArrow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(20)),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: Text(
                  "Upload your logo/personal branding",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(20)),
              Center(
                child: GestureDetector(
                  onTap:
                      setUpProfileState.uploadState == UploadingState.uploading
                          ? null // Disable when uploading
                          : () async {
                              bool uploaded = await ImageUtils.getImage(
                                  ImageSource.gallery, setUpProfileNotifier);
                              if (uploaded) {
                                setUpProfileNotifier
                                    .setUploading(UploadingState.uploaded);
                              }
                            },
                  child: Container(
                    width: context.dynamicScreenWidth(400),
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
                          if (setUpProfileState.uploadState ==
                              UploadingState.uploading)
                            const CircularProgressIndicator()
                          else if (setUpProfileState.uploadState ==
                              UploadingState.uploaded)
                            SvgPicture.asset(ImagesPaths.success,
                                height: 40, width: 40)
                          else
                            SvgPicture.asset(ImagesPaths.gallery,
                                height: 40, width: 40),
                          const SizedBox(height: 10),
                          Text(
                            setUpProfileState.uploadState ==
                                    UploadingState.uploading
                                ? "Uploading image..."
                                : setUpProfileState.uploadState ==
                                        UploadingState.uploaded
                                    ? "Upload Successful"
                                    : "Drag or Select a file",
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.disabled,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(5)),
              Center(
                child: Text(
                  "Upload a logo",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(5)),
              Center(
                child: Text("PNG or JPG less than 20mb",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.disabled)),
              ),
              SizedBox(height: context.dynamicScreenHeight(20)),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: Text(
                  "How will you like to use LanceBox?",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(20)),
              Column(
                children: [
                  // Business Owner Button
                  SizedBox(
                    width: double.infinity,
                    height: context.dynamicScreenHeight(80),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: setUpProfileState.selection == 0
                            ? AppColors.secondary
                            : AppColors.white,
                        side: setUpProfileState.selection == 0
                            ? null
                            : const BorderSide(
                                width: 2, color: AppColors.borderColor),
                      ),
                      onPressed: () {
                        setUpProfileNotifier.selectBusinessOwner();
                      },
                      child: Text(
                        "As a Business Owner",
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: setUpProfileState.selection == 0
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.dynamicScreenHeight(15)),
                  // Freelancer Button
                  SizedBox(
                    width: double.infinity,
                    height: context.dynamicScreenHeight(80),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: setUpProfileState.selection == 1
                            ? AppColors.secondary
                            : AppColors.white,
                        side: setUpProfileState.selection == 1
                            ? null
                            : const BorderSide(
                                width: 2, color: AppColors.borderColor),
                      ),
                      onPressed: () {
                        setUpProfileNotifier.selectFreelancer();
                      },
                      child: Text(
                        "As an individual/Freelancer",
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: setUpProfileState.selection == 1
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.dynamicScreenHeight(30)),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: DefaultButton2(
                  isLoading: setUpProfileState.isLoading,
                  onPressed: setUpProfileState.selection == -1
                      ? () {} // Disable button, using an empty function
                      : () {
                          setUpProfileNotifier.setLoading(true);
                        },
                  text: "Proceed",
                  buttonColor: setUpProfileState.selection == -1
                      ? AppColors
                          .disabled // Grey out the button when no selection
                      : AppColors.primary, // Active button color
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(15)),
              InkWell(
                child: Text(
                  "Skip for now",
                  style: context.textTheme.titleMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
