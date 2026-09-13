import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/states/invoice_state.dart';

import '../../widgets/invoice_button.dart';

class InvoiceScreen extends ConsumerWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceProviderState = ref.watch(invoiceProvider);
    final invoiceProviderNotifier = ref.watch(invoiceProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              "Welcome Subomi",
              textAlign: TextAlign.start,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 20),  // Fixed spacing issue
            Text(
              "What would you like to do now?",
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),  // Fixed spacing issue

            // Button Row
            Row(
              children: [
                InvoiceButton(
                  label: "Create New Invoice",
                  isSelected: invoiceProviderState.selection == 0,
                  onPressed: invoiceProviderNotifier.selectCreateInvoice,
                ),
                const SizedBox(width: 15),
                InvoiceButton(
                  label: "View Previous Invoices",
                  isSelected: invoiceProviderState.selection == 1,
                  onPressed: invoiceProviderNotifier.selectPreviousInvoices,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
