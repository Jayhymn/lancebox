import 'dart:typed_data';

import 'package:lance_box/states/invoice_state.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<Uint8List> forDraft(InvoiceDraftModel draft) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          final headerColor = PdfColor.fromHex('#0D3B66');
          final primaryColor = PdfColor.fromHex('#54ACFF');

          final rows = <pw.TableRow>[
            pw.TableRow(
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#F0F0F9'),
              ),
              children: [
                _cell('Item', bold: true, color: headerColor, align: pw.Alignment.centerLeft),
                _cell('Qty', bold: true, color: headerColor, align: pw.Alignment.centerRight),
                _cell('Unit Price', bold: true, color: headerColor, align: pw.Alignment.centerRight),
                _cell('Amount', bold: true, color: headerColor, align: pw.Alignment.centerRight),
              ],
            ),
            ...draft.items.map(
              (item) => pw.TableRow(
                children: [
                  _cell(
                    '${item.title.isNotEmpty ? item.title : 'Untitled item'}'
                    '${item.description.isNotEmpty ? '\n${item.description}' : ''}',
                    align: pw.Alignment.centerLeft,
                  ),
                  _cell(item.quantity, align: pw.Alignment.centerRight),
                  _cell(item.price, align: pw.Alignment.centerRight),
                  _cell(_formatAmount(draft.currency, item.amount),
                      align: pw.Alignment.centerRight),
                ],
              ),
            ),
          ];

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: headerColor,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Text(
                  'LanceBox Invoice',
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  _labelBlock('Invoice No.', draft.invoiceNumber),
                  _labelBlock('Date', draft.date.isNotEmpty ? draft.date : '—'),
                ],
              ),
              pw.SizedBox(height: 20),
              _labelBlock('From', draft.yourName),
              pw.SizedBox(height: 8),
              _labelBlock('Bill To', draft.clientName),
              pw.SizedBox(height: 24),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: primaryColor),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                padding: pw.EdgeInsets.zero,
                child: pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColor.fromHex('#E6E6E6'),
                    width: 0.5,
                  ),
                  children: rows,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                  width: 180,
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F0F0F9'),
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _cell('Total', bold: true, color: headerColor),
                      _cell(
                        draft.formattedTotal,
                        bold: true,
                        color: headerColor,
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Divider(color: PdfColor.fromHex('#E6E6E6')),
              pw.SizedBox(height: 12),
              pw.Text(
                'Bank Details',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: headerColor,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(fontSize: 11),
                  children: [
                    _plainSpan(
                        'Account: ${draft.accountName.isNotEmpty ? draft.accountName : '—'}'),
                    _plainSpan(
                        '\nBank: ${draft.bankName.isNotEmpty ? draft.bankName : '—'}'),
                    _plainSpan(
                        '\nAccount No: ${draft.bankNumber.isNotEmpty ? draft.bankNumber : '—'}'),
                    _plainSpan(
                        '\nPayment Terms: ${draft.paymentTerms.isNotEmpty ? draft.paymentTerms : '—'}'),
                  ],
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'Generated with LanceBox · PrimeTrust Bank digital invoicing',
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColor.fromHex('#B2B2B2'),
                ),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _labelBlock(String label, String value) {
    return pw.RichText(
      text: pw.TextSpan(
        style: const pw.TextStyle(fontSize: 11),
        children: [
          pw.TextSpan(
            text: '$label\n',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#333333'),
            ),
          ),
          pw.TextSpan(
            text: value.isNotEmpty ? value : '—',
            style: pw.TextStyle(color: PdfColor.fromHex('#333333')),
          ),
        ],
      ),
    );
  }

  static pw.Widget _cell(
    String text, {
    bool bold = false,
    PdfColor? color,
    pw.Alignment? align,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Align(
        alignment: align ?? pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: color ?? PdfColor.fromHex('#333333'),
          ),
        ),
      ),
    );
  }

  static pw.TextSpan _plainSpan(String text) {
    return pw.TextSpan(
      text: text,
      style: pw.TextStyle(color: PdfColor.fromHex('#333333')),
    );
  }

  static String _formatAmount(String currency, String amount) {
    if (amount.isEmpty) return '$currency 0.00';
    return '$currency $amount';
  }
}