import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';

class TransactionReceipt {
  /// Generates a PDF receipt for a transaction from the transaction history
  static Future<String> generateAndSaveReceipt({
    required Transaction transaction,
    required BuildContext context,
  }) async {
    // Format the transaction data
    final formattedDate = DateFormat('dd-MM-yyyy').format(transaction.created_at);
    final formattedTime = DateFormat('hh:mm:ss a').format(transaction.created_at);
    final timestamp = '$formattedDate | $formattedTime';
    
    // Generate the PDF document
    final pdf = await _generateReceipt(
      transaction: transaction,
      timestamp: timestamp,
      context: context,
    );
    
    // Create the file path
    final String filePath = await _getReceiptFilePath(transaction.id);
    
    // Save the PDF file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    
    // Return the path to the saved file
    return filePath;
  }
  
  /// Gets the path of an already generated receipt
  static Future<String> getReceiptPath(int transactionId) async {
    return await _getReceiptFilePath(transactionId);
  }
  
  /// Helper method to get the file path for a transaction receipt
  static Future<String> _getReceiptFilePath(int transactionId) async {
    final fileName = 'Transaction_${transactionId}_Receipt.pdf';
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
  
  /// Internal method to generate the PDF document
  static Future<pw.Document> _generateReceipt({
    required Transaction transaction,
    required String timestamp,
    required BuildContext context,
  }) async {
    final pdf = pw.Document();
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    
    // Format currency with proper number formatting
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    final formattedAmount = numberFormat.format(transaction.amount);
    final formattedFee = numberFormat.format(transaction.transaction_fees ?? 0);
    final formattedTotal = numberFormat.format(transaction.totalAmount);
    
    // Determine the transaction type display
    String transactionTypeDisplay = transaction.transactionTypeDisplay;
    
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
                              'Goh Betoch Bank',
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
                          'Transaction Receipt',
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
                      ],
                    ),
                    // Right side - Transaction details
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Transaction ID: ${transaction.id}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Date: $timestamp',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.only(top: 5),
                          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: pw.BoxDecoration(
                            color: transaction.isCompleted 
                              ? PdfColors.green100 
                              : transaction.isPending 
                                ? PdfColors.orange100 
                                : PdfColors.red100,
                            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                          ),
                          child: pw.Text(
                            transaction.status.toUpperCase(),
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: transaction.isCompleted 
                                ? PdfColors.green800 
                                : transaction.isPending 
                                  ? PdfColors.orange800 
                                  : PdfColors.red800,
                            ),
                          ),
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

                // Transaction Details
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Left column - Transaction Info
                          pw.Expanded(
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
                                pw.Text(
                                  'Transaction Type:',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  transactionTypeDisplay,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Direction:',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  transaction.isOutgoing ? 'Outgoing' : 'Incoming',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                if (transaction.reference != null) ...[
                                  pw.SizedBox(height: 4),
                                  pw.Text(
                                    'Reference:',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    transaction.reference!,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Right column - Counterparty Details
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  transaction.isOutgoing ? "Recipient Details" : "Sender Details",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(primaryColor.value),
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                if (transaction.counterparty_name != null) ...[
                                  pw.Text(
                                    'Name:',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    transaction.counterparty_name!,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                                if (transaction.bank_code != null) ...[
                                  pw.SizedBox(height: 4),
                                  pw.Text(
                                    'Bank:',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    transaction.bank_code!,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                                if (transaction.account_number != null) ...[
                                  pw.SizedBox(height: 4),
                                  pw.Text(
                                    'Account Number:',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    transaction.account_number!,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Financial Details
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
                      _buildPaymentRow('Transaction Amount', formattedAmount, transaction.currency),
                      if (transaction.transaction_fees != null && transaction.transaction_fees! > 0)
                        _buildPaymentRow('Transaction Fee', formattedFee, transaction.currency),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border(
                            top: pw.BorderSide(color: PdfColors.grey300),
                          ),
                        ),
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: _buildPaymentRow('Total', formattedTotal, transaction.currency, isBold: true),
                      ),
                    ],
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
                    // Status stamp
                    _buildStatusStamp(transaction.status),
                  ],
                ),

                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    if (transaction.reference != null)
                      pw.Container(
                        width: 100,
                        height: 100,
                        child: pw.BarcodeWidget(
                          color: PdfColors.black,
                          barcode: pw.Barcode.qrCode(),
                          data: 'https://www.gohbetochbank.com/verify?ref=${transaction.reference}',
                        ),
                      )
                    else
                      pw.Container(width: 100),
                      
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

  static pw.Widget _buildPaymentRow(String label, String amount, String currency, {bool isBold = false}) {
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
            '$currency $amount',
            style: style,
          ),
        ],
      ),
    );
  }
  
  static pw.Widget _buildStatusStamp(String status) {
    PdfColor stampColor;
    String stampText;
    
    switch (status.toLowerCase()) {
      case 'completed':
        stampColor = PdfColors.green700;
        stampText = 'COMPLETED';
        break;
      case 'pending':
        stampColor = PdfColors.orange700;
        stampText = 'PENDING';
        break;
      case 'failed':
        stampColor = PdfColors.red700;
        stampText = 'FAILED';
        break;
      default:
        stampColor = PdfColors.grey700;
        stampText = status.toUpperCase();
    }
    
    return pw.Container(
      width: 80,
      height: 80,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(
          color: stampColor,
          width: 2,
        ),
      ),
      child: pw.Center(
        child: pw.Transform.rotate(
          angle: -0.4,
          child: pw.Text(
            stampText,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: stampColor,
            ),
          ),
        ),
      ),
    );
  }
} 