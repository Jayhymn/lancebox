import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/progress_section.dart';
import 'package:lance_box/presentation/widgets/default_button_2.dart';
import 'package:lance_box/presentation/widgets/lance_box_input_field.dart';
import 'package:lance_box/shared/constants/routes.dart';

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
                    color: Colors.black45,
                  ),
                ),
                Text(
                  "New Invoice",
                  textAlign: TextAlign.start,
                  style: context.textTheme.titleMedium,
                ),
                const ProgressRow(
                  progressItems: [
                    {'label': 'Invoice Details', 'isGreyed': false},
                    {'label': 'Bank Details'},
                    {'label': 'Preview Invoice'},
                    {
                      'label':
                          'Preview Invoice Download Invoice/Send to Client',
                      'flex': 2
                    },
                  ],
                  isFinalStep: false,
                ),
                const InvoiceDetailsForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InvoiceDetailsForm extends StatelessWidget {
  const InvoiceDetailsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          spacing: 20,
          children: [
            LanceIBoxInputField(
              onSaved: (value) {},
              onChanged: (value) {},
              validator: (value) {
                return "";
              },
              labelText: "Invoice Number",
              inputType: TextInputType.number,
              hintText: "01",
              percentScreenWidth: 0.43,
              autoFills: const [AutofillHints.telephoneNumber],
            ),
            LanceIBoxInputField(
              onSaved: (value) {},
              onChanged: (value) {},
              validator: (value) {
                return "";
              },
              labelText: "Client's Name",
              inputType: TextInputType.text,
              textCaps: true,
              hintText: "Enter Client's Name",
              autoFills: const [AutofillHints.name],
            ),
            LanceIBoxInputField(
              onSaved: (value) {},
              onChanged: (value) {},
              validator: (value) {
                return "";
              },
              labelText: "Your Name",
              inputType: TextInputType.text,
              textCaps: true,
              hintText: "Enter Your Name",
              autoFills: const [AutofillHints.name],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanceIBoxInputField(
                  onSaved: (value) {},
                  onChanged: (value) {},
                  validator: (value) {
                    return "";
                  },
                  labelText: "Insurance Date",
                  inputType: TextInputType.datetime,
                  textCaps: true,
                  hintText: "22/03/2023",
                  percentScreenWidth: 0.43,
                  autoFills: const [AutofillHints.name],
                ),
                LanceIBoxInputField(
                  onSaved: (value) {},
                  onChanged: (value) {},
                  validator: (value) {
                    return "";
                  },
                  labelText: "Currency",
                  inputType: TextInputType.number,
                  hintText: "01",
                  percentScreenWidth: 0.43,
                  autoFills: const [AutofillHints.telephoneNumber],
                ),
              ],
            ),
            // SizedBox(height: context.sizeWidth(5),),
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
            LanceIBoxInputField(
              onSaved: (value) {},
              onChanged: (value) {},
              validator: (value) {
                return "";
              },
              labelText: "Invoice Title",
              inputType: TextInputType.name,
              textCaps: true,
              hintText: "Enter Invoice Title",
              autoFills: const [AutofillHints.name],
            ),
            LanceIBoxInputField(
              onSaved: (value) {},
              onChanged: (value) {},
              validator: (value) {
                return "";
              },
              labelText: "Item Description",
              inputType: TextInputType.text,
              hintText: "Enter a Description",
              autoFills: const [],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanceIBoxInputField(
                  onSaved: (value) {},
                  onChanged: (value) {},
                  validator: (value) {
                    return "";
                  },
                  labelText: "Quantity",
                  inputType: TextInputType.datetime,
                  textCaps: true,
                  hintText: "e.g 2.00",
                  percentScreenWidth: 0.43,
                  autoFills: const [AutofillHints.name],
                ),
                LanceIBoxInputField(
                  onSaved: (value) {},
                  onChanged: (value) {},
                  validator: (value) {
                    return "";
                  },
                  labelText: "Price",
                  inputType: TextInputType.number,
                  hintText: "e.g 3,000,000.00",
                  percentScreenWidth: 0.43,
                  autoFills: const [AutofillHints.telephoneNumber],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LanceIBoxInputField(
                  onSaved: (value) {},
                  onChanged: (value) {},
                  validator: (value) {
                    return "";
                  },
                  labelText: "Amount",
                  inputType: TextInputType.datetime,
                  textCaps: true,
                  hintText: "0.00",
                  percentScreenWidth: 0.75,
                  autoFills: const [AutofillHints.name],
                ),
                SvgPicture.asset(
                  ImagesPaths.trashIcon,
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.dashboard);
              },
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
                  "N 0.00",
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
                  "N 0.00",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: context.textTheme.bodyMedium,
                ),
                Text(
                  "N 0.00",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: context.dynamicScreenHeight(30),
            ),
            DefaultButton2(
              isLoading: false,
              onPressed: () {
                // if (!formState.isLoading &&
                //     formNotifier.submitForm()) {
                Navigator.pushNamed(context, Routes.addBankDetailsScreen);
                // }
              },
              labelColor: AppColors.white,
              text: "Preview Invoice",
              buttonColor: AppColors.disabled,
            )
          ],
        ),
      ),
    );
  }
}
