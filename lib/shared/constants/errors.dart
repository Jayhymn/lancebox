class LanceBoxErrors {
  LanceBoxErrors._();

  static const String emailRequired = "Please enter your email";
  static const String invalidEmail = "Please enter a valid email";
  static const String passwordRequired = "Please enter your password";
  static const String passwordTooShort = "Password must be at least 8 characters";
  static const String passwordMismatch = "Passwords do not match";
  static const String nameRequired = "Please enter your name";

  static const String networkError =
      "Unknown error. Please check your internet and try again";
  static const String tooManyRequests =
      "Server received too many requests. Please try again after some time";
}
