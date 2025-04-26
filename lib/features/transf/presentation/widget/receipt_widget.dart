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

    // Status color - green for completed
    final statusColor = PdfColor(0, 0.7, 0, 1); // Green color for COMPLETED

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with bank info and transaction details
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side - Bank logo and name
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
                          'Goh Betoch Bank',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(primaryColor.value),
                          ),
                        ),
                      ],
                    ),
                    // Right side - Transaction details
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Row(
                      children: [
                        pw.Text(
                              'Transaction ID: ${transactionId}',
                          style: const pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        pw.Text(
                          'Date: $timestamp',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.only(top: 4),
                          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: pw.BoxDecoration(
                            color: status.toUpperCase() == 'COMPLETED' ? statusColor : PdfColors.red,
                            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                          ),
                          child: pw.Text(
                            status.toUpperCase(),
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Text(
                  'Transaction Receipt',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromInt(primaryColor.value),
                  ),
                ),
                
                pw.SizedBox(height: 10),
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

                // Transaction Information Section
                pw.SizedBox(height: 10),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                    // Left column - Transaction Information
                          pw.Expanded(
                      flex: 1,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                            "Transaction Information",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(primaryColor.value),
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                          _buildInfoRow('Transaction Type:', transactionType),
                          _buildInfoRow('External Transfer', 'Yes'),
                          _buildInfoRow('Direction:', 'Outgoing'),
                          _buildInfoRow('RRN:', transactionRef),
                              ],
                            ),
                          ),
                    // Right column - Recipient Details
                          pw.Expanded(
                      flex: 1,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                            "Recipient Details",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(primaryColor.value),
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                          _buildInfoRow('Name:', toName),
                          _buildInfoRow('Bank:', toBank),
                          _buildInfoRow('Account Number:', toAccountId),
                              ],
                            ),
                          ),
                        ],
                ),

                // Payment Details
                pw.SizedBox(height: 20),
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

                pw.SizedBox(height: 10),
                _buildPaymentRow('Transaction Amount', amount, currency),
                _buildPaymentRow('Transaction Fee', 0.00, currency),
                pw.Divider(color: PdfColors.grey300),
                _buildPaymentRow('Total', amount, currency, isBold: true),

                pw.Spacer(),

                // Footer with bank name and QR code
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Bank name
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
                      ],
                    ),
                    
                    // Status stamp
                    status.toUpperCase() == 'COMPLETED' ? 
                    pw.Container(
                      width: 70,
                      height: 70,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(
                          color: statusColor,
                          width: 2,
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'COMPLETED',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ) : pw.SizedBox(),
                  ],
                ),

                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 80,
                      height: 80,
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
                          'This is an electronic receipt for your records.',
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.grey700,
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

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(
              fontSize: 10,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentRow(String label, double amount, String currency, {bool isBold = false}) {
    final style = isBold
        ? pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          )
        : const pw.TextStyle(fontSize: 10);

    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: style),
          pw.Text(
            '$currency ${amount.toStringAsFixed(2)}',
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