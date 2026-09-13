// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';
import 'package:lance_box/presentation/widgets/email_form_field.dart';
import 'package:lance_box/presentation/widgets/password_form_field.dart';

import '../../../states/sign_up_state.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return Scaffold(
      body: SafeArea(
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
                  "Looks like you're new here!",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  "Let’s create your account",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleSmall,
                ),
                SizedBox(height: context.sizeHeight(0.05)),
                Form(
                  key: formState.formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        EmailFormField(
                          onSaved: (value) {
                            formNotifier.updateEmail(value ?? "");
                          },
                          onChanged: (value) {
                            formNotifier.validateEmail(value);
                          },
                          validator: (value) =>
                              formNotifier.validateEmail(value ?? ""),
                          labelText: 'Email Address',
                        ),
                        SizedBox(height: context.dynamicScreenHeight(15)),
                        PasswordFormField(
                          onChanged: (value) =>
                              formNotifier.validatePassword(value),
                          onSaved: (value) =>
                              formNotifier.updatePassword(value ?? ""),
                          validator: (value) =>
                              formNotifier.validatePassword(value ?? ""),
                          obscureText: formState.obscurePassword,
                          toggleVisibility: formNotifier.togglePasswordVisibility,
                          labelText: 'Password',
                        ),
                        SizedBox(height: context.dynamicScreenHeight(15)),
                        PasswordFormField(
                          onChanged: (value) =>
                              formNotifier.validatePassword(value),
                          onSaved: (value) =>
                              formNotifier.updatePassword(value ?? ""),
                          validator: (value) =>
                              formNotifier.validatePassword(value ?? ""),
                          obscureText: formState.obscurePassword,
                          toggleVisibility: formNotifier.togglePasswordVisibility,
                          labelText: 'Confirm Password',
                        ),
                        SizedBox(height: context.dynamicScreenHeight(15)),
                        FormError(errors: formState.errors),
                        SizedBox(height: context.dynamicScreenHeight(15)),
                        DefaultButton(
                          isLoading: formState.isLoading,
                          onPressed: () async {
                            if (!formState.isLoading &&
                                formNotifier.submitForm()) {
                              Navigator.pushNamed(context, '/setup');
                            }
                          },
                          text: "Sign Up",
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.sizeHeight(0.01)),
                Text(
                  "Or",
                  style: context.textTheme.titleMedium,
                ),
                SizedBox(height: context.sizeHeight(0.01)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: ImagesPaths.google,
                      press: () {},
                    ),
                    SocialCard(
                      icon: ImagesPaths.facebook,
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: context.dynamicScreenHeight(20)),
                SizedBox(
                  width: context.dynamicScreenWidth(320),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By signing up you agree to our ',
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(context, '/terms'),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Policy',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(context, '/policy'),
                        ),
                      ],
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

  // void firebaseErrorHandler(
  //     FirebaseAuthException authException, SignUpFormNotifier formNotifier) {
  //   switch (authException.code) {
  //     case "user-disabled":
  //     case "user-not-found":
  //       formNotifier.addError(LanceBoxError.userNotFound);
  //       break;
  //
  //     case "wrong-password":
  //       formNotifier.addError(LanceBoxError.emailPasswordCombination);
  //       break;
  //
  //     case "too-many-requests":
  //       formNotifier.addError(LanceBoxError.tooManyRequests);
  //       break;
  //
  //     default:
  //       if (kDebugMode) {
  //         print("error code is ${authException.code}");
  //       }
  //       formNotifier.addError(LanceBoxError.internetConnection);
  //   }
  // }
}
