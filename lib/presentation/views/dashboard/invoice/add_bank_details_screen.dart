import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/progress_section.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/step_progress.dart';
import 'package:lance_box/shared/constants/routes.dart';
import 'package:lance_box/states/invoice_state.dart';

class AddBankDetailsScreen extends ConsumerWidget {
  const AddBankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    ImagesPaths.close,
                    colorFilter: const ColorFilter.mode(
                        Colors.black45, BlendMode.srcIn),
                  ),
                ),
                Text(
                  "Bank Details",
                  textAlign: TextAlign.start,
                  style: context.textTheme.titleMedium,
                ),
                const ProgressRow(
                  progressItems: [
                    StepProgress(label: 'Invoice Details'),
                    StepProgress(label: 'Bank Details', isGreyed: false),
                    StepProgress(label: 'Preview Invoice'),
                    StepProgress(
                      label: 'Preview Invoice Download Invoice/Send to Client',
                      flex: 2,
                    ),
                  ],
                  isFinalStep: false,
                ),
                BankDetailsForm(
                  notifier: ref.read(invoiceDraftProvider.notifier),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BankDetailsForm extends ConsumerStatefulWidget {
  final InvoiceDraft notifier;

  const BankDetailsForm({super.key, required this.notifier});

  @override
  ConsumerState<BankDetailsForm> createState() => _BankDetailsFormState();
}

class _BankDetailsFormState extends ConsumerState<BankDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setBankNumber(value ?? ''),
            onChanged: (value) => widget.notifier.setBankNumber(value),
            validator: _required('Bank number is required'),
            labelText: "Bank Number",
            inputType: TextInputType.number,
            hintText: "Enter your Bank Number",
            autoFills: const [AutofillHints.telephoneNumber],
          ),
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setBankName(value ?? ''),
            onChanged: (value) => widget.notifier.setBankName(value),
            validator: _required('Bank name is required'),
            labelText: "Name of Bank",
            inputType: TextInputType.text,
            textCaps: true,
            hintText: "Enter your Bank Name",
            autoFills: const [AutofillHints.name],
          ),
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setAccountName(value ?? ''),
            onChanged: (value) => widget.notifier.setAccountName(value),
            validator: _required('Account name is required'),
            labelText: "Name of Account",
            inputType: TextInputType.name,
            textCaps: true,
            hintText: "Enter the Name on your Account",
            autoFills: const [AutofillHints.name],
          ),
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setPaymentTerms(value ?? ''),
            onChanged: (value) => widget.notifier.setPaymentTerms(value),
            validator: _required('Terms of payment are required'),
            labelText: "Terms of Payment",
            inputType: TextInputType.text,
            hintText: "e.g payments will be made in installments",
            autoFills: const [],
          ),
          SizedBox(
            height: context.dynamicScreenHeight(30),
          ),
          DefaultButton2(
            isLoading: false,
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                Navigator.pushNamed(context, Routes.previewInvoiceScreen);
              }
            },
            labelColor: AppColors.white,
            text: "Preview Invoice",
            buttonColor: AppColors.primary,
          )
        ],
      ),
    );
  }

  String? Function(String?) _required(String message) {
    return (value) =>
        (value == null || value.trim().isEmpty) ? message : null;
  }
}