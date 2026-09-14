import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/progress_section.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/step_progress.dart';
import 'package:lance_box/shared/constants/routes.dart';
import 'package:lance_box/states/invoice_state.dart';

class CreateInvoiceScreen extends ConsumerWidget {
  const CreateInvoiceScreen({super.key});

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
                  "New Invoice",
                  textAlign: TextAlign.start,
                  style: context.textTheme.titleMedium,
                ),
                const ProgressRow(
                  progressItems: [
                    StepProgress(label: 'Invoice Details', isGreyed: false),
                    StepProgress(label: 'Bank Details'),
                    StepProgress(label: 'Preview Invoice'),
                    StepProgress(
                      label: 'Preview Invoice Download Invoice/Send to Client',
                      flex: 2,
                    ),
                  ],
                  isFinalStep: false,
                ),
                InvoiceDetailsForm(
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

class InvoiceDetailsForm extends ConsumerStatefulWidget {
  final InvoiceDraft notifier;

  const InvoiceDetailsForm({super.key, required this.notifier});

  @override
  ConsumerState<InvoiceDetailsForm> createState() => _InvoiceDetailsFormState();
}

class _InvoiceDetailsFormState extends ConsumerState<InvoiceDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  void _addItem() {
    widget.notifier.addItem();
  }

  void _removeItem(int index) {
    widget.notifier.removeItem(index);
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(invoiceDraftProvider);
    final items = draft.items;

    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setInvoiceNumber(value ?? ''),
            onChanged: (value) => widget.notifier.setInvoiceNumber(value),
            validator: _required('Invoice number is required'),
            labelText: "Invoice Number",
            inputType: TextInputType.number,
            hintText: "01",
            percentScreenWidth: 0.43,
            autoFills: const [AutofillHints.transactionAmount],
          ),
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setClientName(value ?? ''),
            onChanged: (value) => widget.notifier.setClientName(value),
            validator: _required("Client's name is required"),
            labelText: "Client's Name",
            inputType: TextInputType.name,
            textCaps: true,
            hintText: "Enter Client's Name",
            autoFills: const [AutofillHints.name],
          ),
          LanceIBoxInputField(
            onSaved: (value) => widget.notifier.setYourName(value ?? ''),
            onChanged: (value) => widget.notifier.setYourName(value),
            validator: _required('Your name is required'),
            labelText: "Your Name",
            inputType: TextInputType.name,
            textCaps: true,
            hintText: "Enter Your Name",
            autoFills: const [AutofillHints.name],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LanceIBoxInputField(
                onSaved: (value) => widget.notifier.setDate(value ?? ''),
                onChanged: (value) => widget.notifier.setDate(value),
                validator: _required('Date is required'),
                labelText: "Insurance Date",
                inputType: TextInputType.datetime,
                textCaps: true,
                hintText: "22/03/2023",
                percentScreenWidth: 0.43,
                autoFills: const [],
              ),
              LanceIBoxInputField(
                onSaved: (value) => widget.notifier.setCurrency(value ?? ''),
                onChanged: (value) => widget.notifier.setCurrency(value),
                validator: _required('Currency is required'),
                labelText: "Currency",
                inputType: TextInputType.text,
                hintText: "NGN",
                percentScreenWidth: 0.43,
                autoFills: const [],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Invoice Details",
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 17,
              ),
            ),
          ),
          ...items.asMap().entries.map(
                (entry) => _InvoiceItemSection(
                  index: entry.key,
                  item: entry.value,
                  onChanged: (item) =>
                      widget.notifier.updateItem(entry.key, item),
                  onRemove:
                      items.length > 1 ? () => _removeItem(entry.key) : null,
                ),
              ),
          GestureDetector(
            onTap: _addItem,
            child: InkWell(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add New Item",
                  style: context.textTheme.titleMedium?.copyWith(
                    shadows: [
                      const Shadow(
                          color: AppColors.primary, offset: Offset(0, -5))
                    ],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                    decorationThickness: 1.5,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.dynamicScreenHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "VAT",
                style: context.textTheme.bodyMedium,
              ),
              Text(
                "${draft.currency} 0.00",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: context.textTheme.bodyMedium,
              ),
              Text(
                "${draft.currency} 0.00",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                draft.formattedTotal,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.dynamicScreenHeight(30),
          ),
          DefaultButton2(
            isLoading: false,
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                Navigator.pushNamed(context, Routes.addBankDetailsScreen);
              }
            },
            labelColor: AppColors.white,
            text: "Preview Invoice",
            buttonColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  String? Function(String?) _required(String message) {
    return (value) =>
        (value == null || value.trim().isEmpty) ? message : null;
  }
}

class _InvoiceItemSection extends StatelessWidget {
  final int index;
  final InvoiceItemDraft item;
  final ValueChanged<InvoiceItemDraft> onChanged;
  final VoidCallback? onRemove;

  const _InvoiceItemSection({
    required this.index,
    required this.item,
    required this.onChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        LanceIBoxInputField(
          onSaved: (value) =>
              onChanged(item.copyWith(title: value)),
          onChanged: (value) => onChanged(item.copyWith(title: value)),
          validator: _required('Invoice title is required'),
          labelText: "Invoice Title",
          inputType: TextInputType.name,
          textCaps: true,
          hintText: "Enter Invoice Title",
          autoFills: const [AutofillHints.name],
        ),
        LanceIBoxInputField(
          onSaved: (value) =>
              onChanged(item.copyWith(description: value)),
          onChanged: (value) => onChanged(item.copyWith(description: value)),
          validator: _required('Description is required'),
          labelText: "Item Description",
          inputType: TextInputType.text,
          hintText: "Enter a Description",
          autoFills: const [],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LanceIBoxInputField(
              onSaved: (value) =>
                  onChanged(item.copyWith(quantity: value)),
              onChanged: (value) => onChanged(item.copyWith(quantity: value)),
              validator: _required('Quantity is required'),
              labelText: "Quantity",
              inputType: TextInputType.number,
              hintText: "e.g 2.00",
              percentScreenWidth: 0.43,
              autoFills: const [],
            ),
            LanceIBoxInputField(
              onSaved: (value) =>
                  onChanged(item.copyWith(price: value)),
              onChanged: (value) => onChanged(item.copyWith(price: value)),
              validator: _required('Price is required'),
              labelText: "Price",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              hintText: "e.g 3,000,000.00",
              percentScreenWidth: 0.43,
              autoFills: const [],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LanceIBoxInputField(
              onSaved: (value) =>
                  onChanged(item.copyWith(amount: value)),
              onChanged: (value) => onChanged(item.copyWith(amount: value)),
              validator: _required('Amount is required'),
              labelText: "Amount",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              hintText: "0.00",
              percentScreenWidth: 0.75,
              autoFills: const [],
            ),
            if (onRemove != null)
              GestureDetector(
                onTap: onRemove,
                child: SvgPicture.asset(ImagesPaths.trashIcon),
              ),
          ],
        ),
      ],
    );
  }

  String? Function(String?) _required(String message) {
    return (value) =>
        (value == null || value.trim().isEmpty) ? message : null;
  }
}