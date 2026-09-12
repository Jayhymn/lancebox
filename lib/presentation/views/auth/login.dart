import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/email_form_field.dart';
import 'package:lance_box/presentation/widgets/password_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? emailOrNumber;
  String? password;
  final List<String?> errors = [];
  bool isLoggingIn = false;
  bool obscurePassword = true;

  void _addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void _removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              key: _formKey,
              child: Center(
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmailFormField(
                          onSaved: (value) => emailOrNumber = value,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _removeError(error: LanceBoxError.emailIsNull);
                            } else if (Validator.emailValidatorRegExp
                                .hasMatch(value)) {
                              _removeError(error: LanceBoxError.invalidEmail);
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              _addError(error: LanceBoxError.emailIsNull);
                              return "";
                            } else if (!Validator.emailValidatorRegExp
                                .hasMatch(value)) {
                              _addError(error: LanceBoxError.invalidEmail);
                              return "";
                            }
                            return null;
                          }),
                      SizedBox(height: context.dynamicScreenHeight(30)),
                      PasswordFormField(
                        onChanged: (value) {
                          value = value ?? "";
                          if (value.isNotEmpty) {
                            _removeError(error: LanceBoxError.passwordIsNull);
                          } else if (value.length >= 8) {
                            _removeError(error: LanceBoxError.passwordTooShort);
                          }
                          password = value;
                        },
                        onSaved: (newValue) => password = newValue,
                        validator: (value) {
                          if(value!.isEmpty){
                            _addError(error: LanceBoxError.passwordIsNull);
                            return "";
                          } else if(value.length < 8){
                            _addError(error: LanceBoxError.passwordTooShort);
                            return "";
                          }
                          return null;
                        },
                        obscureText: obscurePassword,
                        toggleVisibility: (){
                          setState(() => obscurePassword = !obscurePassword);
                        },
                      ),
                      SizedBox(height: context.dynamicScreenHeight(10)),

                      FormError(errors: errors),

                      SizedBox(height: context.dynamicScreenHeight(10)),

                      DefaultButton(
                        text: "Sign Up",
                        press: () async {
                          errors.clear();
                          if (isLoggingIn) return;

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              // showProgressBar();
                              TextInput.finishAutofillContext();

                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailOrNumber!,
                                      password: password!);

                              if (credential.user != null) {
                                // PrefUtils.saveUserDetails(credential.user!);

                                await Future.delayed(
                                    const Duration(milliseconds: 2500),
                                    hideProgressBar);

                                final user = await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(credential.user!.uid)
                                    .get();

                                ClientModel client = ClientModel.fromJSON(user);

                                bool userExist = user.exists;

                                // if (user.exists) {
                                await LoginUtils.signUpClient(
                                  credential,
                                  userExist ? client.userName! : "",
                                  emailOrNumber!,
                                  client.phoneNumber ?? "N/A",
                                  client.aboutMe ?? "",
                                  photoUrl: userExist ? client.photoUrl : "",
                                  address: userExist ? client.address : "",
                                  country: userExist ? client.country : "",
                                );
                                // }
                              }
                            } on FirebaseAuthException catch (authException) {
                              // Hide progress bar if an error occurs
                              // hideProgressBar(); // Make sure to hide the progress bar here as well

                              firebaseErrorHandler(authException);
                            }
                          }
                        },
                      ),
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
                    if (isLoggingIn) return;

                    // showProgressBar();
                    // googleSignIn(context);
                    // await Future.delayed(
                    //     const Duration(milliseconds: 2500), hideProgressBar);
                  },
                ),
                SocialCard(
                  icon: "assets/icons/facebook-2.svg",
                  press: () async {
                    if (isLoggingIn) return;

                    // showProgressBar();
                    // faceBookSignIn(context);
                    // await Future.delayed(
                    //     const Duration(milliseconds: 2500), hideProgressBar);
                  },
                ),
              ],
            ),
            isLoggingIn ? const LinearProgressIndicator() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void firebaseErrorHandler(FirebaseAuthException authException) {
     switch (authException.code) {
      case "user-disabled":
      case "user-not-found":
        _addError(error: LanceBoxError.userNotFound);
        break;

      case "wrong-password":
        _addError(error: LanceBoxError.emailPasswordCombination);
        break;

      case "too-many-requests":
        _addError(error: LanceBoxError.tooManyRequests);
        break;

      default:
        if (kDebugMode) {
          print(
              "error code is ${authException.code}");
        }
        _addError(error: LanceBoxError.internetConnection);
    }
  }
}
