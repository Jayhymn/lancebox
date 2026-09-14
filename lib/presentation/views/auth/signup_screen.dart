import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/shared/constants/routes.dart';

import '../../../states/sign_up_state.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SignUpTopSection(),
                _SignUpForm(
                  formKey: _formKey,
                  formNotifier: formNotifier,
                  formState: formState,
                  passwordFocusNode: _passwordFocusNode,
                  confirmPasswordFocusNode: _confirmPasswordFocusNode,
                ),
                Text(
                  "Or",
                  style: context.textTheme.titleMedium,
                ),
                const SocialSignUp(),
                const TAndC()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class SignUpTopSection extends StatelessWidget {
  const SignUpTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          ImagesPaths.appIcon,
          height: 40,
          width: 40,
        ),
        SizedBox(height: context.dynamicScreenHeight(10)),
        Text(
          "Looks like you're new here!",
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        Text(
          "Let's create your account",
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }
}

class TAndC extends StatelessWidget {
  const TAndC({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.percentScreenWidth(0.85),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By signing up you agree to our ',
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: 'Terms and Conditions',
              style: const TextStyle(
                color: AppColors.secondary,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Terms and Conditions coming soon')),
                  );
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Policy',
              style: const TextStyle(
                color: AppColors.secondary,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Privacy Policy coming soon')),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({
    required this.formKey,
    required this.formNotifier,
    required this.formState,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
  });

  final GlobalKey<FormState> formKey;
  final SignUpFormNotifier formNotifier;
  final SignUpFormState formState;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            EmailFormField(
              onSaved: (value) {
                formNotifier.updateEmail(value);
              },
              onChanged: (value) {
                formNotifier.validateEmail(value);
              },
              validator: (value) => formNotifier.validateEmail(value),
              labelText: 'Email Address',
            ),
            SizedBox(height: context.dynamicScreenHeight(15)),
            PasswordFormField(
              onChanged: (value) => formNotifier.validatePassword(value),
              onSaved: (value) => formNotifier.updatePassword(value ?? ""),
              validator: (value) => formNotifier.validatePassword(value ?? ""),
              obscureText: formState.obscurePassword,
              toggleVisibility: formNotifier.togglePasswordVisibility,
              labelText: 'Password',
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
              },
            ),
            SizedBox(height: context.dynamicScreenHeight(15)),
            PasswordFormField(
              onChanged: (value) {},
              onSaved: (value) {},
              validator: (value) => formNotifier.validatePasswordMatch(value),
              obscureText: formState.obscurePassword,
              toggleVisibility: formNotifier.togglePasswordVisibility,
              labelText: 'Confirm Password',
              focusNode: confirmPasswordFocusNode,
              textInputAction: TextInputAction.done,
            ),
            FormError(errors: formState.errors),

            SizedBox(height: context.dynamicScreenHeight(25)),
            DefaultButton(
              isLoading: formState.isLoading,
              onPressed: () async {
                final form = formKey.currentState;

                if (form != null && form.validate()) {
                  form.save();
                  formNotifier.setLoading(true);
                  await Future.delayed(const Duration(seconds: 1));
                  if (context.mounted) {
                    formNotifier.setLoading(false);
                    Navigator.pushNamed(context, Routes.setupProfileScreen);
                  }
                }
              },
              text: "Sign Up",
            )
          ],
        ),
      ),
    );
  }
}
