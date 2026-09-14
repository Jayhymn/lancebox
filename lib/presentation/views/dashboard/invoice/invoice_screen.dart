import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/shared/constants/routes.dart';
import 'package:lance_box/states/invoice_state.dart';

import '../../../widgets/invoice_button.dart';

class InvoiceScreen extends ConsumerWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceProviderState = ref.watch(invoiceProvider);
    final invoiceProviderNotifier = ref.watch(invoiceProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                "Welcome Subomi",
                textAlign: TextAlign.start,
                style: context.textTheme.titleMedium,
              ),
              Text(
                "What would you like to do now?",
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 20), // Fixed spacing issue
      
              // Button Row
              Row(
                spacing: 15,
                children: [
                  InvoiceButton(
                    titleLabel: "Create New Invoice",
                    bodyLabel: "create a quick Invoice to send",
                    isSelected: invoiceProviderState.selection == 0,
                    onPressed:(){
                      invoiceProviderNotifier.selectCreateInvoice;
                      Navigator.pushNamed(context, Routes.createInvoiceScreen);
                    },
                    useInkwell: false,
                  ),
                  InvoiceButton(
                    titleLabel: "Invoice Created",
                    bodyLabel: "View All",
                    isSelected: invoiceProviderState.selection == 1,
                    onPressed: invoiceProviderNotifier.selectCreateInvoice,
                    useInkwell: true,
                  ),
                ],
              ),
              const SizedBox(height: 5), // Fixed spacing issue
              Text(
                "Past Invoices",
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 15), // Fixed spacing issue
              Container(
                decoration: BoxDecoration(
                  color: AppColors.offWhite, // Replace with your desired color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  spacing: 20,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        ImagesPaths.searchInvoice,
                        width: context.dynamicScreenWidth(300),
                      ),
                    ),
                    Text(
                      "You don’t have any Invoice history yet. Click the button below to Create your first invoice",
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
