import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/shared/constants/routes.dart';
import 'package:lance_box/states/set_up_state.dart';

import 'auth/account_selection_section.dart';
import 'auth/image_upload_section.dart';
import 'dashboard/invoice/widgets/progress_section.dart';
import 'dashboard/invoice/widgets/step_progress.dart';

class SetUpProfileScreen extends ConsumerWidget {
  const SetUpProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setUpProfileState = ref.watch(setupProvider);
    final setUpProfileNotifier = ref.watch(setupProvider.notifier);

    return Scaffold(
      body: SafeArea(
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: context.percentScreenWidth(0.6),
                    child: const ProgressRow(
                      progressItems: [
                        StepProgress(label: 'Set up Profile'),
                        StepProgress(label: 'Personal Details', isGreyed: false),
                      ],
                      isFinalStep: false,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
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
                AccountSelectionSection(
                  setUpProfileState: setUpProfileState,
                  setUpProfileNotifier: setUpProfileNotifier,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DefaultButton2(
                    isLoading: setUpProfileState.isLoading,
                    onPressed: !setUpProfileState.hasSelection
                        ? () {}
                        : () async {
                            setUpProfileNotifier.setLoading(true);
                            await Future.delayed(const Duration(seconds: 2));
                            if (context.mounted) {
                              setUpProfileNotifier.setLoading(false);
                              Navigator.pushNamed(context, Routes.dashboard);
                            }
                          },
                    text: "Proceed",
                    labelColor: AppColors.white,
                    buttonColor: !setUpProfileState.hasSelection
                        ? AppColors.disabled
                        : AppColors.primary,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.dashboard);
                  },
                  child: Text(
                    "Skip for now",
                    style: context.textTheme.titleMedium?.copyWith(
                      shadows: [
                        const Shadow(
                            color: AppColors.primary, offset: Offset(0, -5))
                      ],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                      decorationThickness: 1.5,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
