import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/constants/validators.dart';

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

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier() : super(SignUpFormState());

  void updateEmail(String? value) {
    state = state.copyWith(email: value);
  }

  void reset() {
    state = SignUpFormState();
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
    state = state.copyWith(
        errors: state.errors.where((e) => e != error).toList());
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!Validator.emailRegExp.hasMatch(value)) {
      return "Invalid email format";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  String? validatePasswordMatch(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Please confirm your password";
    } else if (confirmPassword != state.password) {
      return "Passwords do not match";
    }
    return null;
  }

  bool get isValid {
    return state.email != null &&
        state.email!.isNotEmpty &&
        state.password != null &&
        state.password!.length >= 8;
  }

  bool submitForm() {
    if (!isValid) {
      return false;
    }
    state = state.copyWith(isLoading: true);
    return true;
  }
}

final signUpFormProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>(
  (ref) => SignUpFormNotifier(),
);
