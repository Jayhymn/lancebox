import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetUpProfileState extends StateNotifier<int> {
  SetUpProfileState() : super(0); // Default to Business Owner (0)

  void selectBusinessOwner() {
    state = 0;
  }

  void selectFreelancer() {
    state = 1;
  }
}

// Define a provider to access the SelectedOptionNotifier
final setupProfileProvider = StateNotifierProvider<SetUpProfileState, int>(
      (ref) => SetUpProfileState(),
);