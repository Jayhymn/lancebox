import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  get formKey => GlobalKey<FormState>();

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
  SignUpFormNotifier() : super(SignUpFormState());

  void updateEmail(String value) {
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
}

// Riverpod Provider
final signUpFormProvider = StateNotifierProvider<SignUpFormNotifier, SignUpFormState>(
      (ref) => SignUpFormNotifier(),
);
