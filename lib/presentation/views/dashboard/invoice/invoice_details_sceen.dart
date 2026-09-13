import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/progress_section.dart';
import 'package:lance_box/presentation/widgets/default_button_2.dart';
import 'package:lance_box/presentation/widgets/lance_box_input_field.dart';

class InvoiceDetailsScreen extends ConsumerWidget {
  const InvoiceDetailsScreen({super.key});

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
    return Form(
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
          SizedBox(
            height: context.dynamicScreenHeight(30),
          ),
          DefaultButton2(
            isLoading: false,
            onPressed: () {
              // if (!formState.isLoading &&
              //     formNotifier.submitForm()) {
              Navigator.pushNamed(context, '/bankDetails');
              // }
            },
            labelColor: AppColors.white,
            text: "Preview Invoice",
            buttonColor: AppColors.disabled,
          )
        ],
      ),
    );
  }
}

