// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/email_form_field.dart';
import 'package:lance_box/presentation/widgets/password_form_field.dart';
import 'package:lance_box/presentation/widgets/submission_button.dart';
import 'package:lance_box/states/sign_up_state.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Looks like you're new here!",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: context.sizeHeight(0.05),
            ),
            SizedBox(
              height: context.sizeHeight(0.05),
            ),
            Form(
              key: formState.formKey,
              child: Center(
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmailFormField(
                          onSaved: (value) =>
                              formNotifier.updateEmail(value ?? ""),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              formNotifier
                                  .removeError(LanceBoxError.emailIsNull);
                            } else if (Validator.emailValidatorRegExp
                                .hasMatch(value)) {
                              formNotifier
                                  .removeError(LanceBoxError.invalidEmail);
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              formNotifier.addError(LanceBoxError.emailIsNull);
                              return "";
                            } else if (!Validator.emailValidatorRegExp
                                .hasMatch(value)) {
                              formNotifier.addError(LanceBoxError.invalidEmail);
                              return "";
                            }
                            return null;
                          }),
                      SizedBox(height: context.dynamicScreenHeight(30)),
                      PasswordFormField(
                        onChanged: (value) {
                          value = value ?? "";
                          if (value.isNotEmpty) {
                            formNotifier.removeError(LanceBoxError.passwordIsNull);
                          } else if (value.length < 8) {
                            formNotifier.addError(LanceBoxError.passwordTooShort);
                          }
                          formNotifier.updatePassword(value);
                        },
                        onSaved: (value) =>
                            formNotifier.updatePassword(value ?? ""),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            formNotifier.addError(
                                LanceBoxError.passwordTooShort);
                            return "Password too short";
                          }
                          formNotifier.removeError(LanceBoxError.passwordTooShort);
                          return null;
                        },
                        obscureText: formState.obscurePassword,
                        toggleVisibility: formNotifier.togglePasswordVisibility,
                      ),
                      SizedBox(height: context.dynamicScreenHeight(10)),
                      FormError(errors: formState.errors),
                      SizedBox(height: context.dynamicScreenHeight(10)),
                      SubmissionButton(
                        isLoading: formState.isLoading,
                        onPressed: () async {
                          if (formState.isLoading) return;
                          formNotifier.setLoading(true);

                          if (formState.formKey.currentState!.validate()) {
                            formState.formKey.currentState!.save();
                            // Handle sign up logic here
                          }

                          formNotifier.setLoading(false);
                        },
                        text: "Sign Up",
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: context.sizeHeight(0.02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SocialCard(
                  icon: "assets/icons/google-icon.svg",
                  press: () async {
                    // showProgressBar();
                    // googleSignIn(context);
                    // await Future.delayed(
                    //     const Duration(milliseconds: 2500), hideProgressBar);
                  },
                ),
                SocialCard(
                  icon: "assets/icons/facebook-2.svg",
                  press: () async {

                    // showProgressBar();
                    // faceBookSignIn(context);
                    // await Future.delayed(
                    //     const Duration(milliseconds: 2500), hideProgressBar);
                  },
                ),
              ],
            ),
          ],
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
