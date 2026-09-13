import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';
import 'package:lance_box/presentation/widgets/default_button_2.dart';
import 'package:lance_box/presentation/widgets/lance_box_input_field.dart';
import 'package:lance_box/presentation/widgets/step_indicator.dart';

class BankDetailsScreen extends ConsumerWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                  "Bank Details",
                  textAlign: TextAlign.start,
                  style: context.textTheme.titleMedium,
                ),
                const InvoiceProgressSection(),
                Form(
                  child: Column(
                    spacing: 20,
                    children: [
                      LanceIBoxInputField(
                        onSaved: (value) {},
                        onChanged: (value) {},
                        validator: (value) {
                          return "";
                        },
                        labelText: "Bank Number",
                        inputType: TextInputType.number,
                        hintText: "Enter your Bank Number",
                        autoFills: const [AutofillHints.telephoneNumber],
                      ),
                      LanceIBoxInputField(
                        onSaved: (value) {},
                        onChanged: (value) {},
                        validator: (value) {
                          return "";
                        },
                        labelText: "Name of Bank",
                        inputType: TextInputType.text,
                        textCaps: true,
                        hintText: "Enter your Bank Name",
                        autoFills: const [AutofillHints.name],
                      ),
                      LanceIBoxInputField(
                        onSaved: (value) {},
                        onChanged: (value) {},
                        validator: (value) {
                          return "";
                        },
                        labelText: "Name of Account",
                        inputType: TextInputType.name,
                        textCaps: true,
                        hintText: "Enter the Name on your Account",
                        autoFills: const [AutofillHints.name],
                      ),
                      LanceIBoxInputField(
                        onSaved: (value) {},
                        onChanged: (value) {},
                        validator: (value) {
                          return "";
                        },
                        labelText: "Terms of Payment",
                        inputType: TextInputType.text,
                        hintText: "e.g payments will be made in installments",
                        autoFills: const [],
                      ),
                      SizedBox(height: context.dynamicScreenHeight(30),),
                      DefaultButton2(
                        isLoading: false,
                        onPressed: () {
                          // if (!formState.isLoading &&
                          //     formNotifier.submitForm()) {
                            Navigator.pushNamed(context, '/previewInvoice');
                          // }
                        },
                        labelColor: AppColors.white,
                        text: "Preview Invoice",
                        buttonColor: AppColors.disabled,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InvoiceProgressSection extends StatelessWidget {
  const InvoiceProgressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: StepIndicator(
            text: "Invoice Details",
            isGreyed: true,
          ),
        ),
        Opacity(
          opacity: 0.3,
          child: SvgPicture.asset(
            ImagesPaths.forwardArrow,
          ),
        ),
        const Expanded(
          child: StepIndicator(
            text: "Bank Details",
            isGreyed: false,
          ),
        ),
        Opacity(
          opacity: 1,
          child: SvgPicture.asset(
            ImagesPaths.forwardArrow,
          ),
        ),
        const Expanded(
          child: StepIndicator(
            text: "Preview Invoice",
            isGreyed: true,
          ),
        ),
        Opacity(
          opacity: 1,
          child: SvgPicture.asset(
            ImagesPaths.forwardArrow,
          ),
        ),
        const Expanded(
          flex: 2,
          child: StepIndicator(
            text: "Preview Invoice Download Invoice/Send to Client",
            isGreyed: true,
          ),
        ),
        Opacity(
          opacity: 1,
          child: SvgPicture.asset(
            ImagesPaths.forwardArrow,
          ),
        ),
        SvgPicture.asset(ImagesPaths.success)
      ],
    );
  }
}
