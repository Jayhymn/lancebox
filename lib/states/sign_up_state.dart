import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/constants/errors.dart';
import '../shared/constants/validators.dart';

// Sign Up Form State
class SignUpFormState {
  final String? email;
  final String? password;
  final bool isLoading;
  final bool obscurePassword;
  final List<String> errors;

  SignUpFormState({
    this.email,
    this.password,
    this.isLoading = false,
    this.obscurePassword = true,
    this.errors = const [],
  });

  SignUpFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? obscurePassword,
    List<String>? errors,
  }) {
    return SignUpFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errors: errors ?? this.errors,
    );
  }
}

// State Notifier
class SignUpFormNotifier extends StateNotifier<SignUpFormState> {

  // get formKey => GlobalKey<FormState>();

  SignUpFormNotifier() : super(SignUpFormState());

  void updateEmail(String? value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void addError(String error) {
    if (!state.errors.contains(error)) {
      state = state.copyWith(errors: [...state.errors, error]);
    }
  }

  void removeError(String error) {
    state = state.copyWith(errors: state.errors.where((e) => e != error).toList());
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!Validator.emailValidatorRegExp.hasMatch(value)) {
      return "Invalid email format";
    }
    return null; // No state modifications here
  }

  String? validatePassword(String? value) { // Return String? to be consistent with other validators
    if (value == null || value.length < 8) {
      return "Password must be at least 8 characters long";
    } else { // Only remove the error if validation passes
      return null; // Return null when validation passes
    }
  }

  String? validatePasswordMatch(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Please confirm your password";
    } else if (confirmPassword != state.password) {
      return "Passwords do not match";
    } else {
      return null;
    }
  }

  bool get isValid {
    return state.errors.isEmpty && state.email != null && state.password != null;
  }

  bool submitForm(){
    if (state.errors.isNotEmpty) {
      return false;
    }
    state = state.copyWith(isLoading: true);
    return true;
    }
}

// Riverpod Provider
final signUpFormProvider = StateNotifierProvider<SignUpFormNotifier, SignUpFormState>(
      (ref) => SignUpFormNotifier(),
);

