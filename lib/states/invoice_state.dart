import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceItemDraft {
  final String title;
  final String description;
  final String quantity;
  final String price;
  final String amount;

  const InvoiceItemDraft({
    this.title = '',
    this.description = '',
    this.quantity = '',
    this.price = '',
    this.amount = '',
  });

  InvoiceItemDraft copyWith({
    String? title,
    String? description,
    String? quantity,
    String? price,
    String? amount,
  }) {
    return InvoiceItemDraft(
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }
}

class InvoiceDraftModel {
  final String invoiceNumber;
  final String clientName;
  final String yourName;
  final String date;
  final String currency;
  final List<InvoiceItemDraft> items;
  final String bankNumber;
  final String bankName;
  final String accountName;
  final String paymentTerms;

  const InvoiceDraftModel({
    this.invoiceNumber = '',
    this.clientName = '',
    this.yourName = '',
    this.date = '',
    this.currency = 'NGN',
    this.items = const [],
    this.bankNumber = '',
    this.bankName = '',
    this.accountName = '',
    this.paymentTerms = '',
  });

  double get itemsTotal {
    double total = 0;
    for (final item in items) {
      final qty = double.tryParse(item.quantity) ?? 0;
      final price = double.tryParse(item.price) ?? 0;
      total += qty * price;
    }
    return total;
  }

  String get formattedTotal => '$currency ${itemsTotal.toStringAsFixed(2)}';

  InvoiceDraftModel copyWith({
    String? invoiceNumber,
    String? clientName,
    String? yourName,
    String? date,
    String? currency,
    List<InvoiceItemDraft>? items,
    String? bankNumber,
    String? bankName,
    String? accountName,
    String? paymentTerms,
  }) {
    return InvoiceDraftModel(
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      clientName: clientName ?? this.clientName,
      yourName: yourName ?? this.yourName,
      date: date ?? this.date,
      currency: currency ?? this.currency,
      items: items ?? this.items,
      bankNumber: bankNumber ?? this.bankNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      paymentTerms: paymentTerms ?? this.paymentTerms,
    );
  }
}

class InvoiceState extends StateNotifier<InvoiceStateModel> {
  InvoiceState() : super(InvoiceStateModel());

  void selectCreateInvoice() {
    state = state.copyWith(selection: 0);
  }

  void selectPreviousInvoices() {
    state = state.copyWith(selection: 1);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void reset() {
    state = InvoiceStateModel();
  }
}

class InvoiceStateModel {
  final bool isLoading;
  final int selection;

  InvoiceStateModel({
    this.isLoading = false,
    this.selection = 0,
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

final invoiceProvider = StateNotifierProvider<InvoiceState, InvoiceStateModel>(
  (ref) => InvoiceState(),
);

class InvoiceDraft extends StateNotifier<InvoiceDraftModel> {
  InvoiceDraft() : super(const InvoiceDraftModel());

  void setInvoiceNumber(String value) {
    state = state.copyWith(invoiceNumber: value);
  }

  void setClientName(String value) {
    state = state.copyWith(clientName: value);
  }

  void setYourName(String value) {
    state = state.copyWith(yourName: value);
  }

  void setDate(String value) {
    state = state.copyWith(date: value);
  }

  void setCurrency(String value) {
    state = state.copyWith(currency: value);
  }

  void addItem() {
    state = state.copyWith(items: [...state.items, const InvoiceItemDraft()]);
  }

  void removeItem(int index) {
    if (state.items.length <= 1) return;
    final items = [...state.items]..removeAt(index);
    state = state.copyWith(items: items);
  }

  void updateItem(int index, InvoiceItemDraft item) {
    if (index < 0 || index >= state.items.length) return;
    final items = [...state.items];
    items[index] = item;
    state = state.copyWith(items: items);
  }

  void setBankNumber(String value) {
    state = state.copyWith(bankNumber: value);
  }

  void setBankName(String value) {
    state = state.copyWith(bankName: value);
  }

  void setAccountName(String value) {
    state = state.copyWith(accountName: value);
  }

  void setPaymentTerms(String value) {
    state = state.copyWith(paymentTerms: value);
  }

  void reset() {
    state = const InvoiceDraftModel();
  }
}

final invoiceDraftProvider =
    StateNotifierProvider<InvoiceDraft, InvoiceDraftModel>(
  (ref) => InvoiceDraft(),
);