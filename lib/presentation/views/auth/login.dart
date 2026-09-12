import 'package:flutter/cupertino.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Sign In with your credentials",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Chip(
                    side: BorderSide.none,
                    label: const Text(
                      'Expert / Service Provider',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: isClientChipSelected
                        ? AppColors.mainColor
                        : AppColors.greyOutColor,
                  ),
                  onTap: () => changeChipSelection(true),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                ),
                GestureDetector(
                  child: Chip(
                    side: BorderSide.none,
                    label: const Text(
                      'Client',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: !isClientChipSelected
                        ? AppColors.mainColor
                        : AppColors.greyOutColor,
                  ),
                  onTap: () => changeChipSelection(false),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            !isClientChipSelected
                ? Form(
              key: _formKey,
              child: Center(
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildEmailFormField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      buildPasswordFormField(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () =>
                                Get.to(() => const ForgotPassword()),
                            child: Text(
                              "forgot password?",
                              style:
                              semiHeadingStyle.copyWith(fontSize: 14),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(50)),
                      DefaultButton(
                        text: "Sign In",
                        press: () async {
                          errors.clear();
                          if (isLoggingIn) return;

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              showProgressBar();
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

                                final user = await FirebaseFirestore
                                    .instance
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
                              hideProgressBar();  // Make sure to hide the progress bar here as well

                              switch (authException.code) {
                                case "user-disabled":
                                case "user-not-found":
                                  addError(error: kUserNotFoundError);
                                  break;

                                case "wrong-password":
                                  addError(error: kEmailPasswordError);
                                  break;

                                case "too-many-requests":
                                  addError(error: kTooManyRequests);
                                  break;

                                default:
                                  if (kDebugMode) {
                                    print("error code is ${authException.code}");
                                  }
                                  addError(error: kInternetError);
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
                : Form(
              key: _formKey2,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  FutureBuilder<String>(
                    future: _countryCodeFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return intlPhoneNumberField(countryCode : snapshot.data!);
                      } else {
                        final locale = WidgetsBinding.instance.platformDispatcher.locale;
                        return intlPhoneNumberField(countryCode: locale.countryCode);
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.15),
                  DefaultButton(
                    text: "Send OTP",
                    press: () {
                      if (_formKey2.currentState!.validate()) {
                        _formKey2.currentState!.save();
                        Get.to(() => OtpScreen(
                          phone: _phoneNumberNotifier.value,
                          country: _countryNameNotifier.value,
                        ));
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: semiHeadingStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.right,
                ),
                // SizedBox(width: SizeConfig.screenHeight * 0.02,),
                InkWell(
                  onTap: () {
                    Get.to(() => const SelectCategory());
                  },
                  child: Text(
                    " Create One",
                    style: semiHeadingStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign In with",
                  style: textBodyStyle,
                  textAlign: TextAlign.center,
                ),
                SocalCard(
                  icon: "assets/icons/google-icon.svg",
                  press: () async {
                    if (isLoggingIn) return;

                    showProgressBar();
                    googleSignIn(context);
                    await Future.delayed(
                        const Duration(milliseconds: 2500), hideProgressBar);
                  },
                ),
                SocalCard(
                  icon: "assets/icons/facebook-2.svg",
                  press: () async {
                    if (isLoggingIn) return;

                    showProgressBar();
                    faceBookSignIn(context);
                    await Future.delayed(
                        const Duration(milliseconds: 2500), hideProgressBar);
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
}
