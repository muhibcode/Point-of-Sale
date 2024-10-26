/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// import 'package:flutter/services.dart' show rootBundle;

import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

// import 'package:printing/printing.dart';
final companyAddress =
    'T.I Digital Solution Ltd\n747 High Road, Ilford\nLondon England IG3 8RN\n+44(0) 2035 350 147';
// import '../data.dart';
Future<Uint8List> generateInvoice() async {
  final lorem = pw.LoremText();
  final products = <Product>[
    Product('19874', lorem.sentence(4), 'New', 3.99, 2),
    // Product('98452', lorem.sentence(6), 'New', 15, 2),
    // Product('28375', lorem.sentence(4), 'New', 6.95, 3),
    // Product('95673', lorem.sentence(3), 'New', 49.99, 4),
    // Product('23763', lorem.sentence(2), 'New', 560.03, 1),
    // Product('55209', lorem.sentence(5), 'New', 26, 1),
    // Product('09853', lorem.sentence(5), 'New', 26, 1),
    // Product('23463', lorem.sentence(5), 'New', 34, 1),
    // Product('56783', lorem.sentence(5), 7, 4),
    // Product('78256', lorem.sentence(5), 23, 1),
    // Product('23745', lorem.sentence(5), 94, 1),
    // Product('07834', lorem.sentence(5), 12, 1),
    // Product('23547', lorem.sentence(5), 34, 1),
    // Product('98387', lorem.sentence(5), 7.99, 2),
  ];

  final invoice = Invoice(
    invoiceNumber: '982347',
    products: products,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    paymentInfo:
        '4509 Wiseman Street\nKnoxville, Tennessee(TN), 37929\n865-372-0425',
    tax: .15,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf();
}

class Invoice {
  Invoice({
    required this.products,
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
  });

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.subtotal).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  String? _logo;

  String? _bgShape;

  buildPdf() async {
    // Create a PDF document.
    // final font = await PdfGoogleFonts.nunitoExtraLight();

    final doc = Document();
    // rootBundle.loadString('');
    // _logo = await rootBundle.loadString('logo.svg');
    // _bgShape = await rootBundle.loadString('logo.svg');

    // Add page to the PDF --- .copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
    doc.addPage(
      MultiPage(
        pageTheme: _buildTheme(
          PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        // pageFormat:
        //     PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          pw.SizedBox(height: 20),
          _contentHeader(context),
          pw.SizedBox(height: 20),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // File file = File('');
    // Uint8List bytes = await file.writeAsBytes();
    // Return the PDF file content
    await FileSaver.instance.saveFile(
      name: 'quote',
      bytes: await doc.save(),
      ext: 'pdf',
    );
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pw.Container(
                // height: 20,
                // padding: const pw.EdgeInsets.only(left: 20),
                // alignment: pw.Alignment.topLeft,
                child: pw.Text(
                  'QUOTATION',
                  style: pw.TextStyle(
                    color: PdfColors.grey700,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              pw.Container(
                // decoration: pw.BoxDecoration(
                //   borderRadius:
                //       const pw.BorderRadius.all(pw.Radius.circular(2)),
                //   color: accentColor,
                // ),
                // padding: const pw.EdgeInsets.only(
                //     left: 40, top: 10, bottom: 10, right: 20),
                // alignment: pw.Alignment.topLeft,
                height: 66,
                child: pw.DefaultTextStyle(
                  style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                  child: pw.Column(children: [
                    pw.SizedBox(height: 18),
                    pw.Row(children: [
                      pw.Text(
                        'QUOTE#',
                      ),
                      pw.SizedBox(width: 5),
                      pw.Text(invoiceNumber,
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ]),
                    pw.Row(children: [
                      pw.Text(
                        'ISSUED:',
                      ),
                      pw.SizedBox(width: 5),
                      pw.Text(_formatDate(DateTime.now()),
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ]),
                    pw.Row(children: [
                      pw.Text(
                        'CREATED BY:',
                      ),
                      pw.SizedBox(width: 5),
                      pw.Text('YASIR ALLI',
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ])
                  ]),

                  // child: pw.GridView(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   crossAxisCount: 2,
                  //   children: [
                  //     pw.Text(
                  //       'QUOTE#',
                  //     ),
                  //     pw.Text(invoiceNumber,
                  //         style: TextStyle(fontWeight: FontWeight.normal)),
                  //     pw.Text(
                  //       'ISSUED:',
                  //     ),
                  //     pw.Text(_formatDate(DateTime.now()),
                  //         style: TextStyle(fontWeight: FontWeight.normal)),
                  //     pw.Text(
                  //       'CREATED BY:',
                  //     ),
                  //     pw.Text('YASIR ALLI',
                  //         style: TextStyle(fontWeight: FontWeight.normal)),
                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            // mainAxisAlignment: MainAxisAlignment.,
            crossAxisAlignment:
                pw.CrossAxisAlignment.end, // mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Container(
                // alignment: pw.Alignment.topRight,
                // padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                height: 60,
                child: _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
              ),
              pw.SizedBox(height: 5),
              pw.Text(companyAddress)
              // pw.Container(
              //   color: baseColor,
              //   padding: pw.EdgeInsets.only(top: 3),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 50,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice# $invoiceNumber',
            drawText: false,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      // buildBackground: (context) => pw.FullPage(
      //   ignoreMargins: true,
      //   child: pw.SvgImage(svg: _bgShape!),
      // ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      // mainAxisAlignment: pw.MainAxisAlignment.start,
      // crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Expanded(
        //   child: pw.Container(
        //     margin: const pw.EdgeInsets.symmetric(horizontal: 20),
        //     height: 70,
        //     child: pw.FittedBox(
        //       child: pw.Text(
        //         'Total: ${_formatCurrency(_grandTotal)}',
        //         style: pw.TextStyle(
        //           color: baseColor,
        //           fontStyle: pw.FontStyle.italic,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        pw.Expanded(
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Container(
                // margin: const pw.EdgeInsets.only(right: 10),
                height: 70,
                child: pw.Text(
                  'BILL TO:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: customerAddress,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        pw.TextSpan(
                          text: customerAddress,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(right: 10),
                height: 70,
                child: pw.Text(
                  'SHIP TO:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: customerAddress,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        // pw.TextSpan(
                        //   text: customerAddress,
                        //   style: pw.TextStyle(
                        //     fontWeight: pw.FontWeight.normal,
                        //     fontSize: 10,
                        //   ),
                        // ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.DefaultTextStyle(
      style: const pw.TextStyle(
        fontSize: 10,
        color: _darkColor,
      ),
      child: pw.Column(
        // mainAxisAlignment: pw.MainAxisAlignment.end,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('SUBTOTAL:'),
              pw.Text(_formatCurrency(_total)),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('Delivery:'),
              pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('VAT:'),
              pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('DISCOUNT:'),
              pw.Text('-${(tax * 100).toStringAsFixed(1)}%'),
            ],
          ),
          pw.SizedBox(
            width: 80,
            child: pw.Divider(color: accentColor),
          ),
          pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: baseColor,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text('Total:'),
                pw.Text(_formatCurrency(_grandTotal)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'PRODUCT',
      'DESCRIPTION',
      'CONDITION',
      'QUANTITY',
      'PRICE',
      'SUBTotal'
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.blueGrey300,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

class Product {
  const Product(
      this.sku, this.description, this.condition, this.price, this.quantity);

  final String sku;
  final String description;
  final String condition;
  final double price;
  final int quantity;

  double get subtotal => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return description;
      case 2:
        return condition.toString();

      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(price);

      case 5:
        return _formatCurrency(subtotal);
    }
    return '';
  }
}
