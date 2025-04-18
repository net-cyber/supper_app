import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class ReceiptWidget {
  static Future<pw.Document> generateReceipt({
    required String transactionId,
    required double amount,
    required String fromAccountId,
    required String toAccountId,
    required String fromName,
    required String toName,
    required String fromBank,
    required String toBank,
    required String currency,
    required String status,
    required String timestamp,
    required String transactionRef,
    required String transactionType,
    required Color primaryColor,
    required Color secondaryColor,
    required Color accentColor,
    required Color lightAccent,
    required Color borderColor,
    required Color backgroundColor,
  }) async {
    final pdf = pw.Document();
    final numberFormat = NumberFormat("#,##0.00", "en_US");

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with bank info and receipt title
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side - Bank logo and details
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 40,
                              height: 40,
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(primaryColor.value),
                                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  'GB',
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.white,
                                  ),
                                ),
                              ),
                            ),
                            pw.SizedBox(width: 8),
                            pw.Text(
                              'Goh Betoch Bank Super App',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(primaryColor.value),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Electronic Receipt',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColor.fromInt(secondaryColor.value),
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Addis Ababa, Ethiopia',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          'info@gohbetochbank.com',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          'www.gohbetochbank.com',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromInt(primaryColor.value),
                          ),
                        ),
                      ],
                    ),
                    // Right side - Transaction details
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'TIN No: ${transactionId.padLeft(10, '0')}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          'VAT Reg: 12970',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Container(
                  width: double.infinity,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                  ),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'Transaction Details',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(primaryColor.value),
                      ),
                    ),
                  ),
                ),

                // Sender's Details
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Left column - Sender's Details
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Sender's Details",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(primaryColor.value),
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Account Holder Name:',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  fromName,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Account Number:',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  fromAccountId,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Right column - Beneficiary's Details
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Beneficiary's Details",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(primaryColor.value),
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Account Holder Name:',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  toName,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Account Number:',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  toAccountId,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'Transaction Channel: Goh Betoch Bank Super App',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.Text(
                        'Service Type: ${transactionType}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.Text(
                        'Transfer Reference: $transactionRef',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.Text(
                        'Date: $timestamp',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),

                // Payment Details
                pw.SizedBox(height: 10),
                pw.Container(
                  width: double.infinity,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                  ),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'Payment Details',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(primaryColor.value),
                      ),
                    ),
                  ),
                ),

                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Column(
                    children: [
                      _buildPaymentRow('Transaction Amount', amount, currency),
                      _buildPaymentRow('Service Charge', 0.00, currency),
                      _buildPaymentRow('Excise Tax (15%)', 0.00, currency),
                      _buildPaymentRow('VAT (15%)', 0.00, currency),
                      _buildPaymentRow('Stamp Duty', 0.00, currency),
                      _buildPaymentRow('Discount', 0.00, currency),
                      _buildPaymentRow('Penalty Fee', 0.00, currency),
                      _buildPaymentRow('Interest Fee', 0.00, currency),
                      _buildPaymentRow('Income Tax', 0.00, currency),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border(
                            top: pw.BorderSide(color: PdfColors.grey300),
                          ),
                        ),
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: _buildPaymentRow('Total', amount, currency, isBold: true),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 10),
                pw.Text(
                  'Amount in words: ${_convertToWords(amount)} ${currency} Only',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Spacer(),

                // Footer with bank stamp and QR
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Bank logo and name
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Goh Betoch Bank',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(primaryColor.value),
                          ),
                        ),
                        pw.Text(
                          'Always One Step Ahead!',
                          style: pw.TextStyle(
                            fontSize: 8,
                            color: PdfColor.fromInt(secondaryColor.value),
                          ),
                        ),
                      ],
                    ),
                    // Bank stamp
                    pw.Container(
                      width: 80,
                      height: 80,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(
                          color: PdfColor.fromInt(primaryColor.value),
                          width: 2,
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'GB',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(primaryColor.value),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 100,
                      height: 100,
                      child: pw.BarcodeWidget(
                        color: PdfColors.black,
                        barcode: pw.Barcode.qrCode(),
                        data: 'https://www.gohbetochbank.com/verify?ref=$transactionRef',
                      ),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Terms & Conditions:',
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          'https://www.gohbetochbank.com/privacy-and-security/',
                          style: pw.TextStyle(
                            fontSize: 8,
                            color: PdfColor.fromInt(primaryColor.value),
                          ),
                        ),
                        pw.Text(
                          'For any support please call us at 6321',
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.grey700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _buildPaymentRow(String label, double amount, String currency, {bool isBold = false}) {
    final style = isBold
        ? pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          )
        : const pw.TextStyle(fontSize: 10);

    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: style),
          pw.Text(
            '${amount.toStringAsFixed(2)} $currency',
            style: style,
          ),
        ],
      ),
    );
  }

  static String _convertToWords(double number) {
    // This is a simplified version. You might want to implement a more sophisticated
    // number to words converter based on your requirements
    List<String> units = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'];
    List<String> teens = ['Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'];
    List<String> tens = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];

    if (number == 0) return 'Zero';

    String words = '';
    
    // Handle the whole number part
    int wholePart = number.floor();
    if (wholePart > 0) {
      if (wholePart >= 1000) {
        int thousands = (wholePart / 1000).floor();
        words += '${units[thousands]} Thousand ';
        wholePart %= 1000;
      }
      
      if (wholePart >= 100) {
        int hundreds = (wholePart / 100).floor();
        words += '${units[hundreds]} Hundred ';
        wholePart %= 100;
      }
      
      if (wholePart >= 20) {
        int tensDigit = (wholePart / 10).floor();
        words += '${tens[tensDigit]} ';
        wholePart %= 10;
        if (wholePart > 0) {
          words += '${units[wholePart]} ';
        }
      } else if (wholePart >= 10) {
        words += '${teens[wholePart - 10]} ';
      } else if (wholePart > 0) {
        words += '${units[wholePart]} ';
      }
    }

    // Handle decimal part
    int decimalPart = ((number - number.floor()) * 100).round();
    if (decimalPart > 0) {
      words += 'and ${decimalPart}/100';
    }

    return words.trim();
  }
} 