import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/default_button.dart';
import 'package:lance_box/presentation/widgets/default_button_2.dart';
import 'package:lance_box/presentation/widgets/lance_box_input_field.dart';
import 'package:lance_box/presentation/widgets/step_indicator.dart';
import 'package:shimmer/shimmer.dart';

class PreviewInvoiceScreen extends ConsumerWidget {
  const PreviewInvoiceScreen({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Preview",
                      textAlign: TextAlign.start,
                      style: context.textTheme.titleMedium,
                    ),
                    InkWell(
                      child: Text(
                        "Edit Invoice",
                        style: context.textTheme.titleMedium?.copyWith(
                          shadows: [
                            const Shadow(
                              color: AppColors.primary,
                              offset: Offset(0, -5)
                            )
                          ],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
                          decoration:
                          TextDecoration.underline,
                          decorationColor: AppColors.primary,
                          decorationThickness: 1.5,
                          decorationStyle:
                          TextDecorationStyle.solid,
                        ),
                      ),
                    )
                  ],
                ),
                const InvoiceProgressSection(),
                Expanded(
                  child: true
                      ? Shimmer.fromColors(
                          baseColor: AppColors.offWhite,
                          highlightColor: AppColors.white,
                          child: const Card(
                            elevation: 3,
                            child: PDFView(
                              filePath: "pdfUrl",
                            ),
                          ),
                        )
                      : Card(
                          elevation: 3,
                          child: PDFView(
                            filePath: "pdfUrl",
                          ),
                        ),
                ),
                DefaultButton2(
                  isLoading: false,
                  onPressed: () {
                    // if (!formState.isLoading &&
                    //     formNotifier.submitForm()) {
                    // Navigator.pushNamed(context, '/previewInvoice');
                    // }
                  },
                  labelColor: AppColors.white,
                  text: "Download Pdf",
                  buttonColor: AppColors.primary,
                ),
                DefaultButton2(
                  isLoading: false,
                  onPressed: () {
                    // if (!formState.isLoading &&
                    //     formNotifier.submitForm()) {
                    // Navigator.pushNamed(context, '/previewInvoice');
                    // }
                  },
                  outlineBorder: true,
                  labelColor: AppColors.primary,
                  text: "Send to Client Mail",
                  buttonColor: AppColors.white,
                ),
                SizedBox(
                  height: context.dynamicScreenHeight(20),
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
          child: StepIndicator(
            text: "Preview Invoice",
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
