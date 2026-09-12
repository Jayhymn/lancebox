import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';

class SetUpProfile extends ConsumerWidget {
  const SetUpProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Column(
                children: [

                ],
              ),
              SizedBox(height: context.dynamicScreenHeight(15)),
              DefaultButton(
                isLoading: false,
                onPressed: () async {
                  // if (!formState.isLoading &&
                  //     formNotifier.submitForm()) {
                  //   // Handle sign up logic
                  // }
                },
                text: "Proceed",
              )
            ],
          ),
        ),
      ),
    );
  }
}
