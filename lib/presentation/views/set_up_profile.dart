import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';
import 'package:lance_box/states/set_up_profile_state.dart';

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
              SizedBox(height: context.dynamicScreenHeight(15)),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: Text(
                  "Upload your logo/personal branding",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(15)),
              SizedBox(
                width: context.dynamicScreenWidth(400),
                child: Text(
                  "How will you like to use LanceBox?",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: context.dynamicScreenHeight(15)),
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
                        backgroundColor: setUpProfileState == 0
                            ? AppColors.secondary
                            : AppColors.white,
                        side: setUpProfileState == 0
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
                          fontWeight: setUpProfileState == 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: setUpProfileState == 0
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
                        backgroundColor: setUpProfileState == 1
                            ? AppColors.secondary
                            : AppColors.white,
                        side: setUpProfileState == 1
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
                          fontWeight: setUpProfileState == 1
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: setUpProfileState == 1
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.dynamicScreenHeight(30)),
              DefaultButton(
                isLoading: false,
                onPressed: () async {
                  // Handle the action on button press
                },
                text: "Proceed",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
