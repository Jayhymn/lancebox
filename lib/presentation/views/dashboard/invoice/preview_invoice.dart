import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/progress_section.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/step_progress.dart';
import 'package:lance_box/states/invoice_state.dart';
import 'package:lance_box/utils/pdf_generator.dart';
import 'package:printing/printing.dart';

class PreviewInvoiceScreen extends ConsumerWidget {
  const PreviewInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(invoiceDraftProvider);

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
                    colorFilter: const ColorFilter.mode(
                        Colors.black45, BlendMode.srcIn),
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
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit Invoice",
                        style: context.textTheme.titleMedium?.copyWith(
                          shadows: [
                            const Shadow(
                                color: AppColors.primary,
                                offset: Offset(0, -5))
                          ],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                          decorationThickness: 1.5,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    )
                  ],
                ),
                const ProgressRow(
                  progressItems: [
                    StepProgress(label: 'Invoice Details'),
                    StepProgress(label: 'Bank Details'),
                    StepProgress(label: 'Preview Invoice'),
                    StepProgress(
                      label: 'Preview Invoice Download Invoice/Send to Client',
                      isGreyed: false,
                      flex: 2,
                    ),
                  ],
                  isFinalStep: true,
                ),
                Expanded(
                  child: Card(
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    child: PdfPreview(
                      canChangePageFormat: false,
                      canChangeOrientation: false,
                      canDebug: false,
                      build: (_) => PdfGenerator.forDraft(draft),
                    ),
                  ),
                ),
                DefaultButton2(
                  isLoading: false,
                  onPressed: () async {
                    final bytes = await PdfGenerator.forDraft(draft);
                    if (!context.mounted) return;
                    await Printing.sharePdf(
                      bytes: bytes,
                      filename: 'lancebox_invoice_'
                          '${draft.invoiceNumber.isNotEmpty ? draft.invoiceNumber : 'draft'}.pdf',
                    );
                  },
                  labelColor: AppColors.white,
                  text: "Send to Client Mail",
                  buttonColor: AppColors.primary,
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