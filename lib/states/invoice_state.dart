import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceState extends StateNotifier<InvoiceStateModel> {
  InvoiceState() : super(InvoiceStateModel());

  void selectCreateInvoice() {
    state = state.copyWith(selection: 0, isLoading: false);  // Set selection to 0 (Business Owner)
  }

  void selectPreviousInvoices() {
    state = state.copyWith(selection: 1, isLoading: false);  // Set selection to 1 (Freelancer)
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);  // Toggle the loading state
  }
}

class InvoiceStateModel {
  final bool isLoading;
  final int selection;

  InvoiceStateModel({
    this.isLoading = false,
    this.selection = -1,  // Default to no selection
  });

  InvoiceStateModel copyWith({
    bool? isLoading,
    int? selection,
  }) {
    return InvoiceStateModel(
      isLoading: isLoading ?? this.isLoading,
      selection: selection ?? this.selection,
    );
  }
}

// Define a provider to access the InvoiceStateNotifier
final invoiceProvider = StateNotifierProvider<InvoiceState, InvoiceStateModel>(
      (ref) => InvoiceState(),
);
