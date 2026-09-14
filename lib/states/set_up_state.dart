import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AccountType { none, business, freelancer }

enum UploadingState { notUploading, uploading, uploaded }

class SetUpState extends StateNotifier<SetUpStateModel> {
  SetUpState() : super(SetUpStateModel());

  void selectBusinessOwner() {
    state = state.copyWith(accountType: AccountType.business);
  }

  void selectFreelancer() {
    state = state.copyWith(accountType: AccountType.freelancer);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setUploading(UploadingState uploading) {
    state = state.copyWith(uploadState: uploading);
  }

  void reset() {
    state = SetUpStateModel();
  }
}

class SetUpStateModel {
  final bool isLoading;
  final UploadingState uploadState;
  final AccountType accountType;

  SetUpStateModel({
    this.isLoading = false,
    this.uploadState = UploadingState.notUploading,
    this.accountType = AccountType.none,
  });

  bool get hasSelection => accountType != AccountType.none;

  SetUpStateModel copyWith({
    bool? isLoading,
    UploadingState? uploadState,
    AccountType? accountType,
  }) {
    return SetUpStateModel(
      isLoading: isLoading ?? this.isLoading,
      uploadState: uploadState ?? this.uploadState,
      accountType: accountType ?? this.accountType,
    );
  }
}

final setupProvider = StateNotifierProvider<SetUpState, SetUpStateModel>(
  (ref) => SetUpState(),
);
