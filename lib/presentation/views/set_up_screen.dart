import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';
import 'package:lance_box/presentation/widgets/default_button_2.dart';
import 'package:lance_box/states/set_up_state.dart';

import '../../utils/image_utils.dart';
import '../widgets/dashed_rect_painter.dart';
import '../widgets/selection_button.dart';
import 'auth/account_selection_section.dart';
import 'auth/image_upload_section.dart';

class SetUpProfile extends ConsumerWidget {
  const SetUpProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setUpProfileState = ref.watch(setupProvider);
    final setUpProfileNotifier = ref.watch(setupProvider.notifier);

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagesPaths.appIcon,
                height: 40,
                width: 40,
              ),
              Text(
                "Let's get to know you better",
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              const _ProfileStepIndicator(),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: Text(
                  "Upload your logo/personal branding",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              ImageUploadSection(
                setUpProfileState: setUpProfileState,
                setUpProfileNotifier: setUpProfileNotifier,
              ),
              Center(
                child: Text(
                  "Upload a logo",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Center(
                child: Text("PNG or JPG less than 20mb",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.disabled)),
              ),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: Text(
                  "How will you like to use LanceBox?",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              AccountSelectionSection(
                setUpProfileState: setUpProfileState,
                setUpProfileNotifier: setUpProfileNotifier,
              ),
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

class _ProfileStepIndicator extends StatelessWidget {
  const _ProfileStepIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}